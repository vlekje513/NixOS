{ config, pkgs, ... }:

{
  users.users.vlekje = {
    isNormalUser = true;
    description = "vlekje";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
