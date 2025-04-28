# Update And Rebuild - uar
sudo cp -f flake.nix /etc/nixos
sudo cp -f home.nix /etc/nixos
sudo cp -r -f ./modules /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos
