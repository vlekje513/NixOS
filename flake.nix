{
  description = "Fully modular flake-based NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix = {
      url = "github:yaxitech/ragenix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ragenix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./hardware-configuration.nix

        #./modules/home.nix
        ./modules/boot.nix
        ./modules/networking.nix
        ./modules/desktop.nix
        ./modules/pipewire.nix
        ./modules/users/vlekje.nix
        ./modules/root.nix
        ./modules/secrets.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.vlekje = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

      ];

    };


  };
}
