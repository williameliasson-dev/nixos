{ pkgs, ... }: {
  home.packages = with pkgs; [
    swayidle
  ];

  # Swaylock configuration
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

  # Create a selective media detection script
  home.file.".local/bin/check-video-playing" = {
    executable = true;
    text = ''
      #!/bin/sh

      # Get status of all players
      players=$(${pkgs.playerctl}/bin/playerctl -l 2>/dev/null || echo "")

      # If no players, exit with error (allow lock)
      [ -z "$players" ] && exit 1

      for player in $players; do
        # Skip Spotify or other music players you want to ignore
        if [ "$player" = "spotify" ] || [ "$player" = "spotifyd" ]; then
          continue
        fi

        # Check if this player is playing
        status=$(${pkgs.playerctl}/bin/playerctl -p "$player" status 2>/dev/null || echo "")
        if [ "$status" = "Playing" ]; then
          # Video is playing, exit success (prevent lock)
          exit 0
        fi
      done

      # If we get here, no video is playing, exit with error (allow lock)
      exit 1
    '';
  };

  # Swayidle configuration with selective media detection
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.bash}/bin/bash -c '~/.local/bin/check-video-playing || ${pkgs.swaylock-effects}/bin/swaylock -f'";
      }
      {
        timeout = 600;
        command = "${pkgs.bash}/bin/bash -c '~/.local/bin/check-video-playing || ${pkgs.hyprland}/bin/hyprctl dispatch dpms off'";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -f";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -f";
      }
    ];
  };
}
