{
  description = "Bare configuration for a System76 Darter Pro 6";

  # This nixpkgs must be the same one used to build the system76 packages
  inputs.nixpkgs.url = github:NixOS/nixpkgs/30d7b9341291dbe1e3361a5cca9052ee1437bc97;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/852e439c314ba22d6cb91192d05653ceeec4198e;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/3b78e18cc3fe5af1ef6c7c2c2da73abc64b3ec6e;

  outputs = { self, nixpkgs, system76AcpiDkms, system76IoDkms }: {

    nixosModules = {
      compatibleKernel =
        {
          config = {
            boot.kernelPackages = (import nixpkgs {system = "x86_64-linux";}).linuxPackages_5_8;
          };
        };
      system76AcpiDkms =
        {
          config = {
            boot.extraModulePackages = [ system76AcpiDkms.defaultPackage.x86_64-linux ];
        
            # system76_acpi automatically loads on darp6, but system76_io does not.
            # Explicitly load both for consistency.
            boot.kernelModules = [ "system76_acpi" ];
          };
        };
      system76IoDkms =
        {
          config = {
            boot.extraModulePackages = [ system76IoDkms.defaultPackage.x86_64-linux ];
        
            # system76_acpi automatically loads on darp6, but system76_io does not.
            # Explicitly load both for consistency.
            boot.kernelModules = [ "system76_io" ];
          };
        };
    };
  };
}
