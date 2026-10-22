{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };
  boot.loader.systemd-boot.enable = false;

  general-config.enable = true;
  audio.enable = true;
  musnix.enable = true;
  services.keyd.enable = true;

  donny.enable = true;
  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  services.displayManager.ly.enable = true;

  # security.sudo.extraConfig = "Default lecture=\"never\"";
  system.stateVersion = lib.trivial.release;
}
