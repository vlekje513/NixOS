{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    brave
  ];


  virtualisation.docker.enable = true;
  environment.variables.EDITOR = "neovim";
}
