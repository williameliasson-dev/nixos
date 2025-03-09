{ inputs
, pkgs
, ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/shared/kitty.nix
    ../modules/shared/zsh.nix
    ../modules/shared/rofi.nix
    ../modules/shared/vim.nix
    ../modules/shared/hyprpaper/hyprpaper.nix
    ../modules/shared/fastfetch/fastfetch.nix
    ../modules/shared/hyprland/hyperland.nix
    ../modules/shared/waybar.nix
    ../modules/shared/dunst.nix
    ../modules/shared/git.nix
    ../modules/shared/xdg-portal.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    packages = with pkgs; [
      gh
      slack
      dbeaver-bin
      firefox
      mariadb_114
      yazi
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      devenv
      xwayland
      wl-clipboard
      kubectl
      sshfs
      spotify
      docker-compose
      ledger-live-desktop
      adwaita-icon-theme
      mongodb-compass
      vscode
      gnome-keyring
      libsecret
      libgnome-keyring
      fastfetch
      ripgrep
      pavucontrol
      bluez
      bluez-tools
      sbc
      wireplumber
      killall
      btop
      grim
      slurp
      insomnia
      rofi-power-menu
      obsidian
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };

  programs.gh.enable = true;
}
