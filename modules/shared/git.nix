{
  programs.git = {
    enable = true;
    userName = "williameliasson-dev";
    userEmail = "williameliasson5@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };
}
