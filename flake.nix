{
  description = "Bare configuration for a System76 Darter Pro 6";

  # This nixpkgs must be the same one used to build the system76 packages
  inputs.nixpkgs.url = github:NixOS/nixpkgs/2247d824fe07f16325596acc7faa286502faffd1;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/c1887ce3288d980bb2f5ca6a659ac33a681b28d7;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/20b9c566cd6f0b09e3920f3d3738f1907e22638b;

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
