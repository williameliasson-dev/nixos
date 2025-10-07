{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".config/hypr/hyprland.conf".text = ''
    # Monitors - external on top, laptop on bottom, with explicit resolutions and highest refresh rates
    monitor=DP-3,3440x1440@100,0x0,1
    monitor=DP-5,3440x1440@60,0x0,1
    monitor=HDMI-A-1,3440x1440@100,0x0,1
    monitor=eDP-1,1920x1200@60,760x1440,1
    monitor=,preferred,auto,1

    # Programs
    $terminal = kitty
    $fileManager = yazi
    $menu = rofi -show drun
    $windows = rofi -show window
    $mainMod = SUPER

    # Environment variables
    env = XCURSOR_SIZE,24
    env = XCURSOR_THEME,Adwaita
    env = NIXOS_OZONE_WL,1

    # Input configuration
    input {
        kb_layout = se
        follow_mouse = 1
        touchpad {
            natural_scroll = no
        }
        sensitivity = 0
    }

    # General configuration
    general {
        gaps_in = 0
        gaps_out = 0
        border_size = 1
        col.active_border = rgba(689D6ACC)
        layout = dwindle
        allow_tearing = false
    }

    # Decoration
    decoration {
        rounding = 0
        blur {
            enabled = true
            size = 3
            passes = 1
        }
        shadow {
            enabled = true
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }
    }

    # Animations
    animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    # Dwindle layout
    dwindle {
        pseudotile = true
        preserve_split = true
    }

    # Master layout
    master {
        new_status = master
    }

    # Misc
    misc {
        force_default_wallpaper = 0
    }

    # Application launching
    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, C, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, D, exec, $menu
    bind = $mainMod, TAB, exec, $windows
    bind = $mainMod, P, pseudo,
    bind = $mainMod, J, togglesplit,
    bind = $mainMod, F, fullscreen

    # Move focus with vim binds
    bind = $mainMod, H, movefocus, l
    bind = $mainMod, L, movefocus, r
    bind = $mainMod, K, movefocus, u
    bind = $mainMod, J, movefocus, d

    # Move window with vim binds
    bind = $mainMod SHIFT, H, movewindow, l
    bind = $mainMod SHIFT, L, movewindow, r
    bind = $mainMod SHIFT, K, movewindow, u
    bind = $mainMod SHIFT, J, movewindow, d

    # Switch workspaces
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Screenshot
    bind = $mainMod SHIFT, P, exec, bash -c 'grim -g "$(slurp -d)" - | wl-copy'

    # Move window to workspace
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scratchpad
    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    # Workspace navigation with scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Volume
    bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

    # Media controls
    bind = , XF86AudioPlay, exec, playerctl play-pause
    bind = , XF86AudioPause, exec, playerctl play-pause
    bind = , XF86AudioNext, exec, playerctl next
    bind = , XF86AudioPrev, exec, playerctl previous
    bind = , XF86AudioStop, exec, playerctl stop

    # Brightness
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+

    # Print screen
    bind = , Print, exec, grim - | wl-copy

    # Lock screen
    bind = $mainMod, O, exec, hyprlock

    # Power menu
    bind = $mainMod, ESCAPE, exec, rofi -show power-menu -modi power-menu:rofi-power-menu

    # Fine resize controls
    bind = $mainMod ALT, H, resizeactive, -50 0
    bind = $mainMod ALT, L, resizeactive, 50 0
    bind = $mainMod ALT, K, resizeactive, 0 -50
    bind = $mainMod ALT, J, resizeactive, 0 50

    # Larger resize steps
    bind = $mainMod CTRL ALT, H, resizeactive, -200 0
    bind = $mainMod CTRL ALT, L, resizeactive, 200 0
    bind = $mainMod CTRL ALT, K, resizeactive, 0 -200
    bind = $mainMod CTRL ALT, J, resizeactive, 0 200

    # Mouse bindings
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Startup applications
    exec-once = waybar
    exec-once = hyprpaper
    exec-once = hypridle
    exec-once = hyprctl setcursor Adwaita 24
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
  '';

  home.sessionVariables = {
    KITTY_ENABLE_WAYLAND = "1";
  };
}
