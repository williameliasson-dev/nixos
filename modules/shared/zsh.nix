{ pkgs, ... }:
let
  # Define any local variables here
  customAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake /home/william/nixos#";
    nixflake = "cd /home/william/nixos && nvim flake.nix";
    nas = "sudo sshfs -o allow_other,default_permissions,port=2022,uid=$(id -u),gid=$(id -g) william@192.168.0.110: ~/nas";
    rel-notes = "git --no-pager show --pretty=format:%s -s tags/$(git describe --tags --abbrev=0)..HEAD";
  };
in
{
  # Enable Zsh system-wide
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
    };

    shellAliases = customAliases;

    # Additional Zsh configuration
    initContent = ''
      fastfetch
      # Set PATH
      export PATH=$HOME/.local/bin:$PATH

      # Custom key bindings
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Set default editor
      export EDITOR='nvim'

      # Custom prompt (if not using Oh-My-Zsh theme)
      # PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

      # Add any other custom Zsh configurations here
    '';
  };

  # Ensure Zsh is available
  home.packages = with pkgs; [ zsh ];
}
