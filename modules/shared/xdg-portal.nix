{ pkgs, ... }: {
  home.packages = with pkgs; [
    pipewire
    wireplumber
    pavucontrol
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    wl-clipboard
    grim
    slurp
  ];

  # Configure XDG portal
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      config = {
        common = {
          default = [ "hyprland" ];
        };
        hyprland = {
          default = [ "hyprland" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        };
      };
    };
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
    # Add these specific variables for better portal interaction
    XDG_PORTAL_BACKEND = "hyprland";
  };
}
