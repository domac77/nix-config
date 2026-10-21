{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, musnix, disko, ... }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
    modules = [
        ./machines/vm/configuration.nix
        ./nixos-modules/source.nix
        musnix.nixosModules.musnix
        disko.nixosModules.disko
        {
          disko.devices.disk.main = {
                type = "disk";
                device = "/dev/vda";
                content = {
                  type = "gpt";
                  partitions = [
                    {
                      name = "ESP";
                      type = "EF00";
                      start = "0";
                      end = "1G";
                      content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                        mountOptions = [ "umask=0077" ];
                      };
                    }
                    {
                      name = "root";
                      start = "1G";
                      end = "100%";
                      content = {
                        type = "filesystem";
                        format = "ext4";
                        mountpoint = "/";
                      };
                    }
                  ];
                };
              };
            }
          };
        }
      ];
    };
  };
}
