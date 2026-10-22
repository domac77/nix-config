{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  general-config.enable = true;
  audio.enable = true;
  musnix.enable = true;
  services.keyd.enable = true;
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = false;
  networking.networkmanager.enable = true;
  xdg.mime.enable = true;

  services.udev.packages = [ pkgs.dolphin-emu ];
    boot.extraModulePackages = [
      config.boot.kernelPackages.gcadapter-oc-kmod
    ];

    # to autoload at boot
    boot.kernelModules = [
      "gcadapter_oc"
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  services.displayManager.ly.enable = true;

  system.stateVersion = lib.trivial.release;
}
