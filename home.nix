{ config, lib, pkgs, inputs, ... }: {
  home.username = "donny";
  home.homeDirectory = "/home/donny";

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  misc = {
    fonts.enable = true;
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
}
