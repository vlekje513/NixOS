{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    just
    kdePackages.partitionmanager

  ];


  virtualisation.docker.enable = true;
  environment.variables.EDITOR = "neovim";
}
