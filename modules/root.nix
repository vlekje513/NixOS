{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    just

  ];


  virtualisation.docker.enable = true;
  environment.variables.EDITOR = "neovim";
}
