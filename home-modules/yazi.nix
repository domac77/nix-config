{ config, lib, ... }:
let
  cfg = config.terminal.yazi;
in
{
  options.terminal.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };
  };
};
