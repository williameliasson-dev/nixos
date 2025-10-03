{
  # Config-only mode: assumes hyprpaper is installed via pacman
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = on
    splash = false
    splash_offset = 2.0

    preload = /home/william/nixos/modules/shared/hyprpaper/stairs.jpg

    wallpaper = eDP-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = DP-3, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = DP-5, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = HDMI-A-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = DP-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = DP-2, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
    wallpaper = , /home/william/nixos/modules/shared/hyprpaper/stairs.jpg
  '';
}
