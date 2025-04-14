{ inputs
, pkgs
, ...
}: {
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
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    packages = with pkgs; [
      playerctl
      exercism
      gnumake
      nodejs_22
      openssl
      wireguard-tools
      gh
      slurp
      grim
      wl-clipboard
      gcc
      slack
      firefox-bin
      ungoogled-chromium
      yazi
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      devenv
      xwayland
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
      insomnia
      rofi-power-menu
      obsidian
      dbeaver-bin
      calcure
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };

  programs.gh.enable = true;
}
