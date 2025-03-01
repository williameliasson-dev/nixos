{
  programs.fastfetch = {
    enable = true;
  };
  xdg.configFile."fastfetch/config.jsonc".text = builtins.readFile ./config.jsonc;
}
