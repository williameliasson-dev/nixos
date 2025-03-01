{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/william/nixos/modules/shared/hyprpaper/stairs.jpg" ];

      wallpaper = [
        "DP-3, /home/william/nixos/modules/shared/hyprpaper/stairs.jpg"
      ];
    };
  };
}
