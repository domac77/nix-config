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
          disko.devices {
            disk = {
              main = {
                type = "disk";
                device = "/dev/vda";
                content = {
                  type = "table";
                  format = "msdos";
                  partitions = [
                    {
                      name = "root";
                      start = "0";
                      end = "100%";
                      bootable = true;
                      content = {
                        type = "filesystem";
                        format = "ext4";
                        mountpoint = "/";
                      };
                    }
                  ];
                };
              };
            };
          };
        }
      ];
    };
  };
}
