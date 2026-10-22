{ config, lib, ... }:
let
  cfg = config.donny;
in {
  options.donny.enable = lib.mkEnableOption "my user config";

  config = mkIf cfg.enable {
    users.users.donny = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
      ];
      home = "/home/donny";
      initialPassword = "dd";
    };
  };
}
