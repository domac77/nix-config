{ config, lib, pkgs, ... }:
let
  cfg = config.general-config;
in {
  options.general-config.enable = lib.mkEnableOption "system settings to be applied to all systems";
  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;
    security.polkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

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
  };
}
