{
  description = "Bare configuration for a System76 Darter Pro 6";

  # This nixpkgs must be the same one used to build the system76 packages
  inputs.nixpkgs.url = github:NixOS/nixpkgs/b3251e04ee470c20f81e75d5a6080ba92dc7ed3f;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/f5b2a0f55985b5b5b004ae74c030db5f2208c3ca;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/40ebd9f6a687f481152333d8c709e2f4c6100e72;

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
