{ config, lib, ...}:
let
  cfg = config.general-config;
in {
  options.general-config.enable = lib.mkEnableOption "system settings to be applied to all systems";
  imports = [
    ./audio.nix
    ./keyd.nix
  ] ++ (lib.mkIf cfg.enable [ ./general.nix ]);
}
