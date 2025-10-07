{
  # Config-only mode: assumes hyprpaper is installed via pacman
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = on
    splash = false
    splash_offset = 2.0

    preload = /home/william/dotfiles/modules/shared/hyprpaper/fall.png

    wallpaper = eDP-1, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = DP-3, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = DP-5, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = HDMI-A-1, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = DP-1, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = DP-2, /home/william/dotfiles/modules/shared/hyprpaper/fall.png
    wallpaper = , /home/william/dotfiles/modules/shared/hyprpaper/fall.png
  '';
}
