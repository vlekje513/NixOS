{ config, pkgs, ... }:

{
  users.users.vlekje = {
    isNormalUser = true;
    description = "vlekje";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      vscode
      brave
    ];
  };
  
  virtualisation.vmware.guest = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
