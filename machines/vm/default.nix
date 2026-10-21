localFlake:
{
  config,
  lib,
  pkgs,
  flake-parts-lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    localFlake.config.flake.nixosModules.default
    localFlake.inputs.slippi.nixosModules.default
    localFlake.inputs.musnix.nixosModules.musnix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  services.keyd.enable = true;
  services.pipewire.enable = true;
  # dolphinOptimization.enable = true;

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gnupg
    libnotify
    neovim
    nix-prefetch-git
    pulseaudio
    python3
    tree
    wget
  ];

  services.displayManager.ly.enable = true;
  home-manager.users.donny =
    { config, ... }:
    {
      home.stateVersion = lib.mkDefault "26.11";

      home.packages =
        with pkgs;
        [
          fastfetch
          fd
          fzf
          htop
          ncdu
          nixfmt
          ripgrep
          trash-cli
          unzip
          yt-dlp
          zip
          zig

          ((localFlake.self.packages.${pkgs.stdenv.hostPlatform.system}.nvim).extend
            config.stylix.targets.nixvim.exportedModule
          )
        ];

      misc = {
        mime.enable = true;
        scripts.enable = true;
      };

      terminal =
        let
          enableAndShell = shell: {
            enable = true;
            inherit shell;
          };
        in
        {
          bash.enable = true;
          direnv.enable = true;
          git.enable = true;
          lazygit.enable = true;
          yazi.enable = true;
          tmux = enableAndShell "${pkgs.zsh}/bin/zsh";
        };
    };
  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
