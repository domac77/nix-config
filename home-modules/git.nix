{ config, lib, pkgs, ... }:
let
  cfg = config.terminal.git;
in
{
  options.terminal.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        package = pkgs.gitFull;
        settings = {
          user.name = "domac77";
          user.email = "dony357@outlook.com";
        };
      };

      # git-credential-oauth.enable = true;
    };
  };
};
