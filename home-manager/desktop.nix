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
      cmatrix
      gh
      yazi
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      lunar-client
      devenv
      xwayland
      discord
      wl-clipboard
      kubectl
      sshfs
      steam
      spotify
      docker
      docker-compose
      ledger-live-desktop
      adwaita-icon-theme
      mongodb-compass
      vscode
      gnome-keyring
      libsecret
      libgnome-keyring
      fastfetch
      wl-clipboard
      ripgrep
      pavucontrol
      bluez
      bluez-tools
      sbc
      wireplumber
      killall
      btop
      morgen
      grim
      slurp
      insomnia
      rofi-power-menu
      obsidian
      ungoogled-chromium
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "williameliasson-dev";
      userEmail = "williameliasson5@gmail.com";
      extraConfig = {
        push = { autoSetupRemote = true; };
      };
    };
  };

  programs.gh.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
  };
}
