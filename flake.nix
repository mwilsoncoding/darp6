{
  description = "Bare configuration for a System76 Darter Pro 6";

  inputs.system76AcpiDkms.url = github:mwilsoncoding/system76-acpi-dkms-flake/f5b2a0f55985b5b5b004ae74c030db5f2208c3ca;
  inputs.system76IoDkms.url = github:mwilsoncoding/system76-io-dkms-flake/40ebd9f6a687f481152333d8c709e2f4c6100e72;

  outputs = { system76AcpiDkms, system76IoDkms }: {

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
