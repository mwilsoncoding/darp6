{
  description = "Bare configuration for a System76 Darter Pro 6";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/2d6cbbe4627f6fe4a179c681537b0a3e4f59b732;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms/944395eff1e6882a47a57584be08c6ad7fd8cdfd;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms/b00e2c00958dea3977efbae18d0e5476213201ab;

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
