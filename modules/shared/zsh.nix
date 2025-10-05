{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".zshrc".text = ''
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="af-magic"
    plugins=(git)

    if [ -f "$ZSH/oh-my-zsh.sh" ]; then
      source $ZSH/oh-my-zsh.sh
    fi

    # Aliases
    alias vim="nvim"
    alias ll="ls -l"
    alias update="home-manager switch --flake ~/.config/home-manager#william@laptop"
    alias nixflake="cd ~/.config/home-manager && nvim flake.nix"
    alias nas="sudo sshfs -o IdentityFile=~/.ssh/homelab/id_ed25519 sftp@homelab.local:/mnt/storage ~/nas"
    alias nas-umount="umount ~/nas"
    alias rel-notes="git --no-pager show --pretty=format:%s -s tags/\$(git describe --tags --abbrev=0)..HEAD"

    fastfetch

    export PATH=$HOME/.local/bin:$PATH
    export EDITOR='nvim'

    #NVM

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # Load zsh plugins
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh

    # Key bindings for history substring search
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down


    export PATH=/usr/bin:/usr/local/bin:$PATH
  '';

  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
  ];
}
