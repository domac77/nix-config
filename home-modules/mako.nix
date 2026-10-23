{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.graphic.mako;
in
{
  options.graphic.mako = {
    enable = mkEnableOption "Enable Mako";
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra Mako configuration";
    };
    height = mkOption {
      type = types.int;
      default = 100;
      description = "Set the notification height";
    };
    margin = mkOption {
      type = types.str;
      default = "10";
      description = "Set the margin of each edge";
    };
    padding = mkOption {
      type = types.str;
      default = "5";
      description = "Set the padding of each edge";
    };
    timeout = mkOption {
      type = types.int;
      default = 15000;
      description = "Set the notification timeout";
    };
    font = {
      name = mkOption {
        type = types.str;
        default = "JetBrainsMonoNerdFont";
        description = "Set the font name";
      };
      size = mkOption {
        type = types.either types.float types.int;
        default = 12;
        description = "Set the font size";
      };
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        # font = "${cfg.font.name} ${toString cfg.font.size}";
        defaultTimeout = cfg.timeout;
        borderRadius = config.desktop.hyprland.roundBorders.roundingAmount;
        inherit (cfg) margin padding;
      };
    };
  };
};
