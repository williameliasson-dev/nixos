# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS configuration repository using Nix flakes with integrated Home Manager. It manages system configurations for both desktop and laptop machines, with modular configuration files organized by function.

## Architecture

### Repository Structure
- `flake.nix` - Main flake configuration defining inputs, outputs, and system configurations
- `system/` - NixOS system configurations (desktop-configuration.nix, laptop-configuration.nix)
- `home-manager/` - Home Manager configurations (desktop.nix, laptop.nix) 
- `modules/shared/` - Reusable configuration modules for applications and services

### Configuration Types
- **NixOS Configurations**: Two systems defined - "desktop" and "laptop"
- **Home Manager Configurations**: Standalone configurations for user "william"
- **Shared Modules**: Individual .nix files for specific applications (vim, git, hyprland, etc.)

### Key Components
- Uses Hyprland as the window manager with Wayland
- Includes nixvim for Neovim configuration with LSP support
- Docker virtualization enabled
- Audio through PipeWire
- Bluetooth support with experimental features

## Common Commands

### Building and Switching Configurations
```bash
# Build and switch NixOS configuration (desktop)
sudo nixos-rebuild switch --flake .#desktop

# Build and switch NixOS configuration (laptop)  
sudo nixos-rebuild switch --flake .#laptop

# Switch Home Manager configuration only (desktop)
home-manager switch --flake .#"william@desktop"

# Switch Home Manager configuration only (laptop)
home-manager switch --flake .#"william@laptop"

# Test configuration without switching
sudo nixos-rebuild test --flake .#desktop
```

### Development Commands
```bash
# Update flake inputs
nix flake update

# Show flake info
nix flake show

# Check flake for issues
nix flake check

# Build without switching (faster testing)
nixos-rebuild build --flake .#desktop
```

### Package Management
```bash
# Search for packages
nix search nixpkgs <package-name>

# Install package temporarily
nix shell nixpkgs#<package-name>

# Run package without installing
nix run nixpkgs#<package-name>
```

## Development Workflow

1. Edit configuration files in appropriate directories
2. Test changes with `nixos-rebuild test` or `home-manager switch`
3. If satisfied, use `nixos-rebuild switch` to make changes permanent
4. Commit changes to git after successful builds

## Module System

Each application/service has its own module in `modules/shared/`:
- Individual .nix files configure specific programs
- Modules are imported in home-manager configurations
- Settings are declarative and reproducible

## Important Notes

- The system user is "william" with zsh as default shell
- Docker group membership is configured for the user
- Hyprland with Wayland session is the primary desktop environment
- System allows unfree packages globally
- Uses systemd-boot with 0 timeout
- Time zone set to Europe/Stockholm with Swedish locale settings