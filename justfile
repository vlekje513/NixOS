# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

uar:
  # Update And Rebuild - uar
  cd ~/Documents/NixOS/
  sudo cp -f flake.nix /etc/nixos
  sudo cp -f home.nix /etc/nixos
  sudo cp -r -f ./modules /etc/nixos
  sudo nixos-rebuild switch --flake /etc/nixos

gituar:
  # Update And Rebuild - uar
  cd ~/Documents/NixOS/
  git pull
  sudo cp -f flake.nix /etc/nixos
  sudo cp -f home.nix /etc/nixos
  sudo cp -f justfile /etc/nixos
  sudo cp -r -f ./modules /etc/nixos
  sudo nixos-rebuild switch --flake /etc/nixos

uardebug:
  cd ~/Documents/NixOS/
  sudo cp -f flake.nix /etc/nixos
  sudo cp -f home.nix /etc/nixos
  sudo cp -r -f ./modules /etc/nixos
  sudo nixos-rebuild switch --flake /etc/nixos --show-trace --verbose

relhome:
  home-manager switch
