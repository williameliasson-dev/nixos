{ pkgs, ... }: {
  home.packages = with pkgs; [
    hypridle
    hyprlock
    playerctl
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = screenshot
        blur_size = 8
        blur_passes = 3
        noise = 0.0117
        contrast = 1.3000
        brightness = 0.8000
        vibrancy = 0.2100
        vibrancy_darkness = 0.0
    }

    background {
        monitor =
        color = rgba(0, 0, 0, 0.3)
    }

    input-field {
        monitor =
        size = 300, 60
        outline_thickness = 2
        dots_size = 0.2
        dots_spacing = 0.2
        dots_center = true
        dots_rounding = -1
        outer_color = rgba(255, 255, 255, 0.3)
        inner_color = rgba(255, 255, 255, 0.0)
        font_color = rgb(255, 255, 255)
        fade_on_empty = true
        fade_timeout = 2000
        placeholder_text =
        hide_input = false
        position = 0, -120
        halign = center
        valign = center
        rounding = 25
        shadow_passes = 4
        shadow_size = 10
        shadow_color = rgba(0, 0, 0, 0.3)
        shadow_boost = 1.2
    }

    label {
        monitor =
        text = cmd[update:1000] echo "$(date "+%H:%M")"
        color = rgba(255, 255, 255, 0.9)
        font_size = 80
        font_family = FiraCode Nerd Font Mono
        position = 0, 200
        halign = center
        valign = center
        shadow_passes = 2
        shadow_size = 3
        shadow_color = rgba(0, 0, 0, 0.5)
    }

    label {
        monitor =
        text = cmd[update:1000] echo "$(date "+%A, %B %d")"
        color = rgba(255, 255, 255, 0.7)
        font_size = 24
        font_family = FiraCode Nerd Font Mono
        position = 0, 120
        halign = center
        valign = center
        shadow_passes = 2
        shadow_size = 3
        shadow_color = rgba(0, 0, 0, 0.5)
    }

    label {
        monitor =
        text = cmd[update:1000] echo "$(date "+%Y")"
        color = rgba(255, 255, 255, 0.5)
        font_size = 16
        font_family = FiraCode Nerd Font Mono
        position = 0, 90
        halign = center
        valign = center
    }
  '';

  xdg.configFile."hypr/hypridle.conf".text = ''
     general {
         lock_cmd = pidof hyprlock || hyprlock
         before_sleep_cmd = loginctl lock-session
         after_sleep_cmd = hyprctl dispatch dpms on
     }
     # Lock after 5 minutes
    listener {
         timeout = 300
         on-timeout = ~/.local/bin/check-video-playing || hyprlock
     }
     # Disable screen after 10 minutes
     listener {
         timeout = 600
         on-timeout = ~/.local/bin/check-video-playing || hyprctl dispatch dpms off
         on-resume = hyprctl dispatch dpms on
     }
     # Suspend after 15 minutes
     listener {
         timeout = 900
         on-timeout = ~/.local/bin/check-video-playing || systemctl suspend
     }
  '';

  home.file.".local/bin/check-video-playing" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
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

  # Start hypridle service
  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
