{ config, lib, ... }:
let
  cfg = config.misc.zathura;
in
{
  options.misc.zathura.enable = lib.mkEnableOption "zathura";

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  };
}
