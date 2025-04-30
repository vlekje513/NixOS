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
  nixos-rebuild switch --flake /etc/nixos --use-remote-sudo

uardebug:
  cd ~/Documents/NixOS/
  sudo cp -f flake.nix /etc/nixos
  sudo cp -f home.nix /etc/nixos
  sudo cp -r -f ./modules /etc/nixos
  sudo nixos-rebuild switch --flake /etc/nixos
  nixos-rebuild switch --flake /etc/nixos --use-remote-sudo --show-trace --verbose
