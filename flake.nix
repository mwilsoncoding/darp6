{
  description = "Bare configuration for a System76 Darter Pro 6";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/2d6cbbe4627f6fe4a179c681537b0a3e4f59b732;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/cd2ceb51315be334c82dcd181a2d5c4199b3d800;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/4e4785e2999c226b76e8b516529272d1e2a9b8b3;

  outputs = { self, nixpkgs, system76AcpiDkms, system76IoDkms }: {

    nixosConfigurations.darp6 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        system76AcpiDkms.nixosModules.system76-acpi-dkms
        system76IoDkms.nixosModules.system76-io-dkms
      ];
    };
  };
}
