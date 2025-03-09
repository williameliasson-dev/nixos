{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "/home/william/nixos/modules/shared/hyprpaper/stairs.jpg" ];
      wallpaper = [
        "eDP-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "DP-3, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "DP-5, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "HDMI-A-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "DP-1, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "DP-2, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
        "DP-4, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
      ];
    };
  };
}
