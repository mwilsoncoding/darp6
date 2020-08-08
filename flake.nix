{
  description = "Bare configuration for a System76 Darter Pro 6";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/2d6cbbe4627f6fe4a179c681537b0a3e4f59b732;
  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/f5b2a0f55985b5b5b004ae74c030db5f2208c3ca;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/2cb4dd614469a9aa9c5b5cce9c92cef6349ea247;

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
