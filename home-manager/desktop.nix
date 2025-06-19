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
    ../modules/shared/chromium.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "william";
    homeDirectory = "/home/william";
    packages = with pkgs; [
      claude-code
      cmatrix
      gcc
      ripgrep
      nodejs_22
      yazi
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      devenv
      xwayland
      discord
      wl-clipboard
      kubectl
      sshfs
      adwaita-icon-theme
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
      ungoogled-chromium
      spotify
    ];
    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
    gh.enable = true;
  };
}
