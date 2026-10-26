{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  services.displayManager.ly.enable = true;

  general-config.enable = true;
  audio.enable = true;
  musnix.enable = true;
  services.keyd.enable = true;
  hardware.bluetooth.enable = true;
  networking.networkmanager.enable = true;
  xdg.mime.enable = true;
  donny.enable = true;
  programs.hyprland.enable = true;

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.flatpak.enable = true;

  services.udev.packages = [ pkgs.dolphin-emu ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];
  boot.kernelModules = [
    "gcadapter_oc"
  ];

  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  system.stateVersion = lib.trivial.release;
}
