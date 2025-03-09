{
  programs.git = {
    enable = true;
    userName = "williameliasson-dev";
    userEmail = "williameliasson5@gmail.com";

    ignores = [
      ".devenv*"
      "devenv.local.nix"
      ".direnv"
      ".envrc"
    ];

    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };
}
