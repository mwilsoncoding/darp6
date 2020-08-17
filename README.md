# darp6
Nix flake for bare setup of a System76 Darter Pro laptop

## How to use
Write your own system flake that lists this repository as an input:
```nix
{
  description = "My laptop";

  inputs.darp6.url = github:mwilsoncoding/darp6/latest-sha-0000000000;

  inputs.nixpkgs.url = ...; # your preference

  outputs = { self, nixpkgs, darp6 }: {

    nixosConfigurations.nixtop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixpkgs.nixosModules.notDetected
        darp6.nixosModules.system76AcpiDkms
        darp6.nixosModules.system76IoDkms
        darp6.nixosModules.compatibleKernel
        ({pkgs, lib, ...}: {
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

          imports = [ ./hardware-configuration.nix ];

          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          nix = {
            package = pkgs.nixFlakes;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
            registry.nixpkgs.flake = nixpkgs;
          };

          ...

        })
      ];
    };
  };
}
```
