{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "DP-3,3440x1440@99.9,0x0,1"
        "DP-5,3440x1440@59.97,0x0,1"
        "HDMI-A-1,3440x1440@99.9,0x0,1"
        ",preferred,auto,1"
        "eDP-1,1920x1200@60,760x1440,1"
      ];

      # Set programs that you use
      "$terminal" = "kitty";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun";
      "$windows" = "rofi -show window";
      "$mainMod" = "SUPER";

      # Some default env vars
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Adwaita"
        "NIXOS_OZONE_WL=1"
      ];

      # Input configuration
      input = {
        kb_layout = "se";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };

      # General configuration
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(689D6ACC)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration configuration
      decoration = {
        rounding = 0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # Animations configuration
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle layout configuration
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout configuration
      master = {
        new_status = "master";
      };

      # Misc configuration
      misc = {
        force_default_wallpaper = -1;
      };

      # Key bindings
      bind = [
        # Application launching
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, TAB, exec, $windows"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, F, fullscreen"

        # Move focus with mainMod + vim binds
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move window with mainMod + vim binds
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Screenshot draggable
        "$mainMod SHIFT, P, exec, bash -c 'grim -g \"$(slurp -d)\" - | wl-copy'"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Workspace navigation with scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Volume binds
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        #Brightness
        ", XF86MonBrightnessDown, exec, xbacklight -dec 5"
        ", XF86MonBrightnessUp, exec, xbacklight -inc 5"

        # Lock Screen
        "$mainMod, O, exec, hyprlock"

        # Power menu
        "$mainMod, ESCAPE, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

        # Window sizing shortcuts
        # Fine resize controls
        "$mainMod ALT, H, resizeactive, -50 0"
        "$mainMod ALT, L, resizeactive, 50 0"
        "$mainMod ALT, K, resizeactive, 0 -50"
        "$mainMod ALT, J, resizeactive, 0 50"

        # Larger resize steps
        "$mainMod CTRL ALT, H, resizeactive, -200 0"
        "$mainMod CTRL ALT, L, resizeactive, 200 0"
        "$mainMod CTRL ALT, K, resizeactive, 0 -200"
        "$mainMod CTRL ALT, J, resizeactive, 0 200"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Startup applications
      "exec-once" = [
        "waybar"
        "hyprctl setcursor Adwaita 24"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };
}
