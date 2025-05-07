{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    just
    tree
    tldr
    tmux

  ];


  virtualisation.docker.enable = true;
  environment.variables.EDITOR = "neovim";
}
