{
  description = "Bare configuration for a System76 Darter Pro 6";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/2d6cbbe4627f6fe4a179c681537b0a3e4f59b732;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/cd2ceb51315be334c82dcd181a2d5c4199b3d800;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/4e4785e2999c226b76e8b516529272d1e2a9b8b3;

  outputs = { self, nixpkgs, system76AcpiDkms, system76IoDkms }: {

    nixosModules = {
      system76-acpi-dkms =
        { pkgs, ... }:
        {
          config = {
            boot.extraModulePackages = [ system76AcpiDkms.defaultPackage.x86_64-linux ];
        
            # system76_acpi automatically loads on darp6, but system76_io does not.
            # Explicitly load both for consistency.
            boot.kernelModules = [ "system76_acpi" ];
          };
        };
      system76-io-dkms =
        { pkgs, ... }:
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
