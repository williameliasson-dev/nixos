{ pkgs, ... }: {
  home.packages = with pkgs; [
    swayidle
    hyprlock # Hyprland's native lock screen
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    # Gruvbox-themed Hyprlock configuration

    # Background configuration
    background {
        monitor =
        color = rgba(40, 40, 40, 1.0)
        # Optional: blur background
        blur_size = 5
        blur_passes = 3
    }

    # Input field configuration
    input-field {
        monitor =
        size = 220, 50
        outline_thickness = 2
        dots_size = 0.33
        dots_spacing = 0.15
        dots_center = false
        outer_color = rgb(131, 165, 152)    # Blue from Gruvbox
        inner_color = rgb(40, 40, 40)       # Background
        font_color = rgb(235, 219, 178)     # Foreground
        fade_on_empty = true
        placeholder_text = <i>Password...</i>
        hide_input = false
        position = 0, -20
        halign = center
        valign = center
    }

    # Time widget
    label {
        monitor =
        text = cmd[update:1000] echo "$(date "+%H:%M")"
        color = rgba(235, 219, 178, 1.0)
        font_size = 50
        font_family = JetBrains Mono Nerd Font
        position = 0, -140
        halign = center
        valign = center
    }

    # Date widget
    label {
        monitor =
        text = cmd[update:1000] echo "$(date "+%A, %d %B %Y")"
        color = rgba(235, 219, 178, 1.0)
        font_size = 18
        font_family = JetBrains Mono Nerd Font
        position = 0, -80
        halign = center
        valign = center
    }

    # Error/failure message
    label {
        monitor =
        text = $WRONG_PASSWORD
        color = rgb(251, 73, 52)            # Red from Gruvbox
        font_size = 16
        font_family = JetBrains Mono Nerd Font
        position = 0, 20
        halign = center
        valign = center
        visible = $FAILED_ATTEMPTS > 0
    }
  '';

  # Keep your media detection script
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

  # Swayidle configuration with hyprlock
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.bash}/bin/bash -c '~/.local/bin/check-video-playing || ${pkgs.hyprlock}/bin/hyprlock'";
      }
      {
        timeout = 1200;
        command = "${pkgs.bash}/bin/bash -c '~/.local/bin/check-video-playing || ${pkgs.hyprland}/bin/hyprctl dispatch dpms off'";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        event = "lock";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];
  };
}
