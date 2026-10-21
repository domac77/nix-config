{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  general-config.enable = true;
  audio.enable = true;
  musnix.enable = true;
  services.keyd.enable = true;

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  services.displayManager.ly.enable = true;

  security.sudo.extraConfig = "Default lecture=\"never\"";

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
