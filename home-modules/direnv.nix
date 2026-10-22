{ config, lib, ... }:
let
  cfg = config.terminal.direnv;
in
{
  options.terminal.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
};
