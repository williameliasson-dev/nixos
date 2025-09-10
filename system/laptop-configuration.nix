{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./laptop-hardware-configuration.nix
  ];

  # Nix configuration
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        substituters = [ "https://cache.nixos.org/" ];
        trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
        always-allow-substitutes = true;
        builders-use-substitutes = true;
        nix-path = config.nix.nixPath;
      };
      channel.enable = true;
      extraOptions = ''
        trusted-users = root william
      '';
      # Make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  # Boot configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Localization
  time.timeZone = "Europe/Stockholm";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };
  console.keyMap = "sv-latin1";

  # System services
  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };

  # Environment configuration
  environment = {
    systemPackages = with pkgs; [
      home-manager
      glib # Provides gdbus
      dbus # General D-Bus utilities
    ];
    # Wayland/Hyprland environment variables
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    sessionVariables = {
      # Wayland support
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      # Default applications
      BROWSER = "chromium";
      DEFAULT_BROWSER = "chromium";
      # Java apps
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # TLP for battery optimization
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  # Audio and screen sharing
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # System security limits
  security = {
    pam = {
      loginLimits = [
        {
          domain = "*";
          type = "soft";
          item = "nofile";
          value = "524288";
        }
        {
          domain = "*";
          type = "hard";
          item = "nofile";
          value = "524288";
        }
      ];
      services = {
        sudo.fprintAuth = true;
        login.fprintAuth = true;
      };
    };
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (action.id == "net.reactivated.fprint.device.enroll") {
                return polkit.Result.YES;
            }
        });
      '';
    };
    rtkit.enable = true;
  };

  # XDG portal configuration (for screen sharing)
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
    config.common.default = [
      "hyprland"
      "wlr"
      "gtk"
    ];
  };

  # System services
  services = {
    # X11 server and keyboard layout
    xserver = {
      enable = true;
      xkb = {
        layout = "se";
        variant = "";
      };
    };
    # Printing support
    printing.enable = true;
    # Bluetooth manager
    blueman.enable = true;
    # Fingerprint reader
    fprintd.enable = true;
    # Login manager
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/Hyprland";
          user = "greeter";
        };
      };
    };
  };

  # Virtualization
  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };
    };
  };

  # User configuration
  users.users.william = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "william";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "input"
      "plugdev"
      "audio"
      "bluetooth"
      "video"
      "render"
    ];
  };

  # Hardware configuration
  hardware = {
    acpilight.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          MultiProfile = "multiple";
          Class = "0x00240414";
          FastConnectable = true;
        };
        Properties = {
          "Media.CodecSelectors" = "sbc_xq aac ldac aptx aptx_hd";
          "Media.SupportedCodecs" = "sbc_xq aac ldac aptx aptx_hd";
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  # Programs
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}
