{
  description = "Fully modular flake-based NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hardware-configuration.nix

        ./modules/base.nix
        ./modules/networking.nix
        ./modules/desktop.nix
        ./modules/pipewire.nix
        ./modules/users/vlekje.nix
        ./modules/packages.nix
      ];
    };
  };
}
