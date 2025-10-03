{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/shared/kitty.nix
    ../modules/shared/zsh.nix
    ../modules/shared/rofi.nix
    ../modules/shared/vim.nix
    ../modules/shared/hyprpaper/hyprpaper.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/shared/hyperland.nix
    ../modules/shared/waybar.nix
    ../modules/shared/dunst.nix
    ../modules/shared/git.nix
    ../modules/shared/hyprlock.nix
    ../modules/shared/node.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    packages = with pkgs; [
      lazygit
      zip
      unzip
      mariadb
      exercism
      gnumake
      openssl
      wireguard-tools
      gh
      slurp
      grim
      wl-clipboard
      gcc
      yazi
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      devenv
      kubectl
      sshfs
      adwaita-icon-theme
      gnome-keyring
      libsecret
      libgnome-keyring
      fastfetch
      ripgrep
      sbc
      killall
      btop
      insomnia
      rofi-power-menu
      dbeaver-bin
      calcure
      gnome-boxes
      vscode-js-debug
      claude-code
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };

  programs.gh.enable = true;
}
