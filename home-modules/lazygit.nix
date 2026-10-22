{ config, lib, ... }:
let
  cfg = config.terminal.lazygit;
in
{
  options.terminal.lazygit.enable = lib.mkEnableOption "lazygit";

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
      };
    };
  };
};
