{ config, pkgs, ... }:

{
  users.users.vlekje = {
    isNormalUser = true;
    description = "vlekje";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      vscode
    ];
  };

  services.vmwareGuest = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
