{
  config,
  flake-parts-lib,
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations = {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        inputs.niri.nixosModules.niri
        (import ../disko/impermanence.nix { device = "/dev/nvme0n1"; })
        (flake-parts-lib.importApply ./laptop { inherit config inputs self; })
      ];
    };

    desktop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        inputs.niri.nixosModules.niri
        (import ../disko/nvme.nix)
        (flake-parts-lib.importApply ./desktop { inherit config inputs self; })
      ];
    }

    vm = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        (import ../disko/vm.nix)
        (flake-parts-lib.importApply ./vm { inherit config inputs self; })
      ];
    }
  };
}
