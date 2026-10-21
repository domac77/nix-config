{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  services.keyd.enable = true;
  audio.enable = true;

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gnupg
    libnotify
    neovim
    nix-prefetch-git
    python3
    tree
    wget
  ];

  services.displayManager.ly.enable = true;

  security.sudo.extraConfig = "Default lecture=\"never\"";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
