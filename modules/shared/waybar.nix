{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        margin-top = 5;
        margin-left = 20;
        margin-right = 20;
        spacing = 5;
        modules-left = [ "custom/logo" "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "custom/power" ];

        "custom/logo" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "󱄅";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";
            "8" = "󰎹";
            "9" = "󰎼";
            "10" = "󰽽";
            urgent = "󰀧";
            default = "󱄅";
          };
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          format = " {usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = " {}% ";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        "network" = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = " {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰤭";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "󰓃" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          tooltip = false;
        };
      };
    };

    style = ''
       * {
         border: none;
         border-radius: 0;
         font-family: "JetBrainsMono Nerd Font", "Roboto", "Font Awesome 5 Free";
         font-size: 14px;
         min-height: 0;
         transition-property: background-color;
         transition-duration: 0.5s;
       }

       window#waybar {
         background-color: rgba(40, 40, 40, 0.8);
         border-radius: 10px;
         color: #ebdbb2;
         transition-property: background-color;
         transition-duration: .5s;
       }

       window#waybar.hidden {
         opacity: 0.2;
       }

      #workspaces button {
      background-color: transparent;
      color: #ebdbb2;
      border-radius: 10px;
      font-size: 18px;
      min-width: 40px;
      min-height: 40px;
      padding: 0 10px;
      margin: 5px;
      }

        #workspaces button label {
        font-size: 18px;
        padding: 0 5px;
        }

       #workspaces button:hover {
         background: rgba(0, 0, 0, 0.2);
         box-shadow: inherit;
         text-shadow: inherit;
       }

       #workspaces button.active {
         background-color: #689d6a;
         color: #282828;
       }

       #workspaces button.urgent {
         background-color: #cc241d;
       }

       #clock,
       #battery,
       #cpu,
       #memory,
       #disk,
       #temperature,
       #backlight,
       #network,
       #pulseaudio,
       #custom-media,
       #custom-power,
       #custom-logo {
         padding: 0 10px;
         color: #ebdbb2;
         background-color: #3c3836;
         border-radius: 10px;
         padding: 0 10px;
         margin: 5px;
       }

       #custom-logo {
         color: #b8bb26;
         font-size: 18px;
       }

       #clock {
         color: #689d6a;
         background-color: transparent;
         font-weight: bold;
       }

       #battery {
         background-color: #98971a;
         color: #282828;
       }

       #battery.charging, #battery.plugged {
         color: #282828;
         background-color: #b8bb26;
       }

       @keyframes blink {
         to {
           background-color: #ebdbb2;
           color: #282828;
         }
       }

       #battery.critical:not(.charging) {
         background-color: #cc241d;
         color: #ebdbb2;
         animation-name: blink;
         animation-duration: 0.5s;
         animation-timing-function: linear;
         animation-iteration-count: infinite;
         animation-direction: alternate;
       }

       #cpu {
         background-color: #d65d0e;
         color: #282828;
       }

       #memory {
         background-color: #458588;
         color: #282828;
       }

       #network {
         background-color: #b16286;
         color: #282828;
       }

       #network.disconnected {
         background-color: #cc241d;
       }

       #pulseaudio {
         background-color: #98971a;
         color: #282828;
       }

       #pulseaudio.muted {
         background-color: #fb4934;
         color: #282828;
       }

       #custom-power {
         background-color: #cc241d;
         color: #282828;
         font-size: 18px;
       }

       tooltip {
         background-color: #282828;
         border: 1px solid #ebdbb2;
       }

       tooltip label {
         color: #ebdbb2;
       }
    '';
  };
}
