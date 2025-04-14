{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    pipewire
    wireplumber
    pavucontrol
    wl-clipboard
    grim
    slurp
  ];

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
    config = {
      common = {
        default = [ "hyprland" "wlr" "gtk" ];
      };
      # Use hyprland portal first, then fall back to wlr
      hyprland = {
        default = [ "hyprland" "wlr" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" "wlr" ];
      };
    };
  };

  # Set environment variables for Wayland
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    # Firefox Wayland
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    # Electron apps
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    # QT apps
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # GTK
    GDK_BACKEND = "wayland";
    # SDL
    SDL_VIDEODRIVER = "wayland";
    # Java apps
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Create portal restart service
  systemd.user.services = {
    # Portal service for Hyprland
    xdg-desktop-portal-hyprland = {
      Unit = {
        Description = "Portal service (Hyprland implementation)";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" "xdg-desktop-portal.service" ];
        Requires = [ "xdg-desktop-portal.service" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.impl.portal.desktop.hyprland";
        ExecStart = "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Service to restart portals in correct order after login
    portal-restarter = {
      Unit = {
        Description = "Restart portals to ensure proper functioning";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "restart-portals" ''
          sleep 3
          systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal-gtk
          sleep 1
          systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland
        ''}";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

  # Create needed directories
  home.activation.createPortalDirs = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/share/xdg-desktop-portal
    chmod 700 $HOME/.local/share/xdg-desktop-portal
  '';
}
