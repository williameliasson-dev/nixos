{
  programs.git = {
    enable = true;
    userName = "williameliasson-dev";
    userEmail = "williameliasson5@gmail.com";
    ignores = [
      ".devenv*"
      "devenv.local.nix"
      "devenv.nix"
      "devenv.lock"
      ".direnv"
      ".envrc"
      ".temp" # Added
      ".tmp" # Added (common variant)
      ".env" # Added
      ".local" # Added
      ".nodejs" # Added
    ];
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };
}
