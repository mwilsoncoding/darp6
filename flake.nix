{
  description = "Bare configuration for a System76 Darter Pro 6";

  # This nixpkgs must be the same one used to build the system76 packages
  inputs.nixpkgs.url = github:NixOS/nixpkgs/b3251e04ee470c20f81e75d5a6080ba92dc7ed3f;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/03b1d057e3242c2471c0803fcfb913cd121d4c08;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/35dfb74275ff1746ec838bd74f473df0dc7692ea;

  outputs = { self, nixpkgs, system76AcpiDkms, system76IoDkms }: {

    nixosModules = {
      compatibleKernel =
        {
          config = {
            boot.kernelPackages = (import nixpkgs {system = "x86_64-linux";}).linuxPackages_latest;
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
