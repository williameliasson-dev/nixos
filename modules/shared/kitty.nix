{
  programs.kitty = {
    enable = true;
    settings = {
      # General settings
      font_family = "FiraCode Nerd Font Mono";
      font_size = 12;
      adjust_line_height = 0;
      adjust_column_width = 0;
      disable_ligatures = "never";

      # Window layout
      window_padding_width = 4;
      hide_window_decorations = "no";

      # Color scheme
      background = "#262626";
      foreground = "#D4D4D4";
      cursor = "#FFFFFF";

      # Other settings
      enable_audio_bell = false;
      update_check_interval = 0;
      allow_remote_control = true;
      
      # Terminal compatibility for SSH
      term = "xterm-256color";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    extraConfig = ''
      # Any additional configuration that doesn't fit into the settings attribute

      background_opacity 0.9

      # For example, complex key mappings:
      map ctrl+shift+d new_tab_with_cwd

      # Gruvbox Dark color scheme

      # The basic colors
      foreground              #ebdbb2
      background              #282828
      selection_foreground    #655b53
      selection_background    #ebdbb2

      # Cursor colors
      cursor                  #8ec07c
      cursor_text_color       #1d2021

      # URL underline color when hovering with mouse
      url_color               #d65d0e

      # The basic 16 colors
      # black
      color0                  #282828
      color8                  #928374

      # red
      color1                  #cc241d
      color9                  #fb4934

      # green
      color2                  #98971a
      color10                 #b8bb26

      # yellow
      color3                  #d79921
      color11                 #fabd2f

      # blue
      color4                  #458588
      color12                 #83a598

      # magenta
      color5                  #b16286
      color13                 #d3869b

      # cyan
      color6                  #689d6a
      color14                 #8ec07c

      # white
      color7                  #a89984
      color15                 #ebdbb2
    '';
  };
}
