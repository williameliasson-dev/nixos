{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = true;

      extraOptions = ''
        trusted-users = root william
      '';

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Define the service to run as root
  systemd.services = {
    NetworkManager-wait-online.enable = false;

    lactd = {
      description = "AMDGPU Control Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
        Type = "simple";
        # Run as root since we need direct hardware access
        User = "root";
        Group = "root";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
  };

  # Install the package system-wide
  environment = {
    systemPackages = [ pkgs.lact ];
    variables = {
      # If cursor is not visible, try to set this to "on".
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  services = {
    xserver = {
      xkb = {
        layout = "se";
        variant = "";
      };
      enable = true;
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      extraConfig.pipewire = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 96000 ];
        };
      };
    };

    blueman.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/Hyprland";
          user = "greeter";
        };
      };
    };
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";
  security.rtkit.enable = true;

  users.users.william = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "william";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
      "audio"
      "bluetooth"
      "video"
      "render"
    ];
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "gtk" "hyprland" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental; # Add this line
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        MultiProfile = "multiple"; # This should be inside General
        Class = "0x00240414";
        FastConnectable = true;
      };
      Properties = {
        "Media.CodecSelectors" = "sbc_xq aac ldac aptx aptx_hd";
        "Media.SupportedCodecs" = "sbc_xq aac ldac aptx aptx_hd";
      };

      Policy = {
        # Add this section
        AutoEnable = true;
      };
    };
  };

  programs = {
    zsh.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
