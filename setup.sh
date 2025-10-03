#!/bin/bash

set -e # Exit on error

echo "=== Arch + Nix + Home Manager Setup Script ==="
echo "=== github.com/williameliasson-dev/nixos ==="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -eq 0 ]; then
	echo -e "${RED}Please run as normal user, not root!${NC}"
	exit 1
fi

echo -e "${GREEN}[1/8] Enabling multilib repository...${NC}"
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
	echo -e "${YELLOW}Enabling multilib for 32-bit support...${NC}"
	sudo sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf
	sudo pacman -Sy
else
	echo -e "${YELLOW}Multilib already enabled${NC}"
fi

echo -e "${GREEN}[2/8] Installing essential Arch packages...${NC}"
sudo pacman -Syu --needed --noconfirm \
	alsa-utils \
	base \
	base-devel \
	bluez \
	bluez-utils \
	btrfs-progs \
	curl \
	docker \
	docker-compose \
	efibootmgr \
	fprintd \
	git \
	hyprland \
	hypridle \
	hyprlock \
	hyprpaper \
	intel-gpu-tools \
	intel-media-driver \
	intel-ucode \
	iwd \
	kitty \
	lib32-mesa \
	lib32-vulkan-intel \
	libva-intel-driver \
	linux \
	linux-firmware \
	mesa \
	networkmanager \
	noto-fonts-emoji \
	openssh \
	pavucontrol \
	pipewire \
	pipewire-alsa \
	pipewire-jack \
	pipewire-pulse \
	polkit-gnome \
	powertop \
	seatd \
	sof-firmware \
	ttf-firacode-nerd \
	vim \
	vulkan-intel \
	wayland-protocols \
	wireplumber \
	xdg-desktop-portal \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-hyprland \
	zram-generator \
	zsh

echo -e "${GREEN}[3/8] Installing Nix...${NC}"
if ! command -v nix &>/dev/null; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
	echo -e "${YELLOW}Nix installed. Reloading daemon...${NC}"
	sudo systemctl daemon-reload
	sudo systemctl enable --now nix-daemon
else
	echo -e "${YELLOW}Nix already installed, skipping...${NC}"
fi

echo -e "${GREEN}[4/8] Enabling Nix flakes...${NC}"
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
	echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf
fi

echo -e "${GREEN}[5/8] Sourcing Nix environment...${NC}"
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

echo -e "${GREEN}[6/8] Cloning dotfiles repo...${NC}"
REPO_URL="https://github.com/williameliasson-dev/nixos.git"
if [ -d ~/.config/home-manager ]; then
	echo -e "${YELLOW}~/.config/home-manager already exists. Backing up...${NC}"
	mv ~/.config/home-manager ~/.config/home-manager.backup.$(date +%s)
fi
git clone "$REPO_URL" ~/.config/home-manager
cd ~/.config/home-manager

echo -e "${GREEN}[7/8] Installing home-manager...${NC}"
echo "Available configurations:"
echo "  - william@desktop"
echo "  - william@laptop"
echo ""
read -p "Which config? (desktop/laptop): " MACHINE_TYPE

if [ "$MACHINE_TYPE" = "desktop" ] || [ "$MACHINE_TYPE" = "laptop" ]; then
	CONFIG_NAME="william@$MACHINE_TYPE"
	echo -e "${YELLOW}Running: nix run home-manager -- switch --flake ~/.config/home-manager#${CONFIG_NAME}${NC}"
	nix run home-manager -- switch --flake ~/.config/home-manager#"$CONFIG_NAME"
else
	echo -e "${RED}Invalid choice. Please run manually:${NC}"
	echo "nix run home-manager -- switch --flake ~/.config/home-manager#william@desktop"
	echo "nix run home-manager -- switch --flake ~/.config/home-manager#william@laptop"
fi

echo -e "${GREEN}[8/8] Setting up auto-start Hyprland (optional)...${NC}"
read -p "Auto-start Hyprland on TTY1 login? (y/n): " AUTO_START
if [[ "$AUTO_START" =~ ^[Yy]$ ]]; then
	# Detect shell
	if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
		PROFILE_FILE="$HOME/.zprofile"
	else
		PROFILE_FILE="$HOME/.bash_profile"
	fi

	if ! grep -q "exec Hyprland" "$PROFILE_FILE" 2>/dev/null; then
		cat >>"$PROFILE_FILE" <<'EOF'

# Auto-start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi
EOF
		echo -e "${GREEN}Auto-start configured in $PROFILE_FILE${NC}"
	else
		echo -e "${YELLOW}Auto-start already configured${NC}"
	fi
fi

echo ""
echo -e "${GREEN}=== Setup Complete! ===${NC}"
echo ""
echo "Next steps:"
echo "1. Log out and log back in (or reboot)"
echo "2. Either Hyprland will auto-start, or type 'Hyprland' to launch"
echo ""
echo "Your dotfiles are at: ~/.config/home-manager"
echo "To rebuild: home-manager switch --flake ~/.config/home-manager#william@$MACHINE_TYPE"
echo ""
echo -e "${YELLOW}Enjoy your declarative setup! 🚀${NC}"
