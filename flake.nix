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

  outputs = { self, nixpkgs, nur, home-manager, musnix, disko, ... }@inputs: {
    homeConfigurations.donny = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nur.overlays.default ];
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home.nix
        ./home-modules
      ];
    };

    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/vm
          ./nixos-modules
          (import ./disko/vm.nix)
          disko.nixosModules.disko
          musnix.nixosModules.musnix
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/desktop
          ./nixos-modules
          (import ./disko/nvme.nix)
          disko.nixosModules.disko
          musnix.nixosModules.musnix
        ];
      };
    };
  };
}
