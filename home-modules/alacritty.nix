{ config, lib, ... }:
let
  inherit (lib) mkOption types;
  cfg = config.terminal.alacritty;
in
{
  options.terminal.alacritty = {
    enable = lib.mkEnableOption "alacritty";
    shell = mkOption {
      type = types.str;
      default = "bash";
      description = "Set the default shell";
    };
  };

  config.programs.alacritty = mkIf cfg.enable {
    enable = true;
    settings = {
      terminal.shell.program = cfg.shell;

      font = {
        size = 13.5;
        normal = {
          family = (if config.fonts.enable then "ZedMonoNerdFont" else "monospace");
          # family = "ZedMonoNerdFont";
          style = "Normal";
        };
      };

      env.TERM = "xterm-256color";
      window.decorations = "none";
    };
  };
};
