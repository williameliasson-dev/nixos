{ pkgs, ... }: {
  home.packages = with pkgs; [ swayidle ];

  programs.swaylock = {
    enable = true;

    package = pkgs.swaylock-effects; # Using swaylock-effects for more visual options
    settings = {
      # Appearance
      color = "282828";
      font = "JetBrains Mono Nerd Font";
      font-size = 24;
      indicator-radius = 100;
      indicator-thickness = 7;
      indicator = true;

      # Effects
      clock = true;
      timestr = "%H:%M";
      datestr = "%a, %B %d";
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      fade-in = 0.1;

      # Indicator colors
      inside-color = "282828AA";
      inside-clear-color = "EBDBB2AA";
      inside-ver-color = "83A598AA";
      inside-wrong-color = "FB4934AA";

      line-color = "00000000";
      line-clear-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      ring-color = "83A598";
      ring-clear-color = "EBDBB2";
      ring-ver-color = "83A598";
      ring-wrong-color = "FB4934";

      separator-color = "00000000";

      text-color = "EBDBB2";
      text-clear-color = "282828";
      text-ver-color = "282828";
      text-wrong-color = "282828";

      # Behavior
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      ignore-empty-password = true;
      show-failed-attempts = true;
    };
  };
}
