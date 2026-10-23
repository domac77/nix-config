{ config, lib, pkgs, inputs, ... }: {
  home.username = "donny";
  home.homeDirectory = "/home/donny";

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };

  misc = {
    fonts.enable = true;
    firefox.enable = true;
    mpv.enable = true;
    zathura.enable = true;
  };

  terminal = {
    alacritty = {
      enable = true;
      shell = "zsh";
    };
    direnv.enable = true;
    git.enable = true;
    lazygit.enable = true;
    newsboat.enable = true;
    nushell.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  home.packages = [
    # Window manager related packages (maybe move into specific module)
    bluetuith
    brightnessctl
    grim
    imv
    pavucontrol
    pcmanfm
    playerctl
    polkit_gnome
    slurp
    wl-clipboard
    wlr-randr

    ani-cli
    anki
    audacity
    bluetuith
    # cava
    fastfetch
    fd
    ffmpeg_6-full
    fzf
    ghostty
    gimp
    htop
    keepassxc
    ncdu
    nixfmt
    obsidian
    obs-studio
    qalculate-qt
    pear-desktop
    ripgrep
    streamlink
    # texliveFull
    trash-cli
    unzip
    winetricks
    wine64
    yewtube
    yt-dlp
    zip
    zotero
    zig
  ];

  desktop = {
    hyprland = {
      enable = false;
      enableAnimations = true;
      enableBlur = true;
      blurSize = 10;
      roundBorders.enable = true;
      startupCommands = [
        # "${pkgs.swaybg}/bin/swaybg -i ${config.theme.wallpaper}"
        "${config.services.mako.package}/bin/mako"
      ];

      # monitor = [ "eDP-1, 1920x1080@60,0x0,1" ];

      extraKeybindings = [
        "SUPER, RETURN, exec, alacritty"
        "SUPER, S, exec, firefox"
        "SUPER SHIFT, S, exec, firefox -p school"
        "SUPER, R, exec, rofi -show drun"
        "SUPER SHIFT, R, exec, rofi -show run"
        "SUPER, P, exec, rofimoji"
        "SUPER, E, exec, pcmanfm"
        "SUPER, B, exec, firefox https://127.0.0.1:8384"
      ];

      windowRules = [
        "float, class:.*"
        "tile, class:^(firefox)\$"
        "tile, class:^(Chromium-browser)\$"
        "tile, class:^(Alacritty)\$"
        "tile, class:^(org.pwmt.zathura)\$"
        "tile, class:^(obsidian)\$"
        # "opacity 0.9 0.9, class:^(Alacritty)\$"
      ];
    };

  };

  graphic = {
    rofi.enable = true;

    mako = {
      enable = true;
      font = {
        name = "JetBrainsMonoNerdFont";
        size = 10;
      };
    };

    waybar = {
      enable = true;
      barHeight = 30;
      terminal = "alacritty";
      soundControl = "pavucontrol";
      wmModules = [ "hyprland/workspaces" ];

      font = {
        name = "JetBrainsMonoNerdFont";
        size = 12.0;
      };
    };
  };
}
