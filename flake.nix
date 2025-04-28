{
  description = "Fully modular flake-based NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";



  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hardware-configuration.nix

        #./modules/home.nix
        ./modules/boot.nix
        ./modules/networking.nix
        ./modules/desktop.nix
        ./modules/pipewire.nix
        ./modules/users/vlekje.nix
        ./modules/root.nix


      ];

    };


  };
}
