{ pkgs, ... }: {
  # No services.pipewire configuration in home-manager
  # Instead, just ensure the right packages are installed
  home.packages = with pkgs; [
    pipewire
    wireplumber
    pavucontrol

    # For screen sharing
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    wl-clipboard
    grim
    slurp
  ];

  # Environment variables for screen sharing
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
