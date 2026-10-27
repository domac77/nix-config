{ config, lib, pkgs, ... }:
let
  inherit (lib) genAttrs mkEnableOption mkIf;
  cfg = config.misc.firefox;

  commonProfileSettings = {
    settings = builtins.fromJSON (builtins.readFile (
      builtins.fetchurl {
        url = "https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js";
        hash = "0h2j5lsv07r81qp8ysjg3d9i9cdzhjw9ip96mxxrh9ajn73p3a9q";
      }
    ));

    search = {
      force = true;
      default = "ddg";
      privateDefault = "ddg";
    };

    extensions.force = true;
    extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      decentraleyes
      df-youtube
      istilldontcareaboutcookies
      privacy-badger
      return-youtube-dislikes
      ublock-origin
      vimium
    ];
  };
in
{
  options.misc.firefox.enable = mkEnableOption "Enable Firefox";
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        fun = commonProfileSettings // {
          isDefault = true;
          bookmarks = {
            force = true;
            settings = [
              {
                name = "youtube";
                url = "https://youtube.com";
              }
            ];
          };
        };
        school = commonProfileSettings // {
          id = 1;
          bookmarks = {
            force = true;
            settings = [
              {
                name = "outlook";
                url = "https://outlook.com";
              }
            ];
          };
        };
      };
    };
  };
