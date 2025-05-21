{ config, pkgs, lib, inputs, ... }:

{
  networking.hostName = "nixosvm";
  networking.networkmanager.enable = true;


  

  
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ]; # For SSH
  services.fail2ban = {
    enable = true;
    maxretry = 20;
  };
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
