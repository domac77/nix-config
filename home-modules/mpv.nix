{ config, lib, pkgs, ... }:
let
  cfg = config.misc.mpv;
in
{
  options.misc.mpv.enable = lib.mkEnableOption "mpv";

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      package =
        with pkgs;
        (mpv.override {
          youtubeSupport = true;
          scripts = [ mpvScripts.mpris ];
        });

      config = {
        hwdec = "auto";
        ytdl-format = "ytdl";
        term-playing-msg = "Now playing: \${media-title}";
      };
    };
  };
};
