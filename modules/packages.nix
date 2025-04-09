{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    brave
  ];


  virtualisation.docker.enable = true;
  environment.variables.EDITOR = "vim";
}
