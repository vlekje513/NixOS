{ config, pkgs, lib, inputs, ... }:

let
  # This should be the public key of the keypair you'll use to encrypt secrets.
  # Generate with `age-keygen` and store the private key securely.
  # The private key will be needed on the machine that *builds* the NixOS configuration
  # if it's not the target machine, or if you're encrypting secrets there.
  # For ragenix, you typically list recipients in .agenix.toml or specify them via CLI.
  # Ragenix itself will use the private keys available to decrypt.
  #
  # For the ragenix NixOS module, it expects private keys to be available in /etc/ragenix/keys
  # or defined via `age.identityPaths`.
  #
  # For this example, we will assume your user's SSH private key can decrypt the age file,
  # or you have an age private key available.
  # Ragenix supports SSH keys for encryption/decryption.
  #
  # Your SSH public key (already in vlekje.nix) is:
  # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5mLMzwlx+4FkB4q3dybESRH4uKYRCqVUNkZs/YL+Nj"
  # You can use this with `ragenix -r "ssh-ed25519 AAAAC..."` or put it in `.agenix.toml`
  #
  # The ragenix module will look for keys in /etc/ssh/ssh_host_ed25519_key by default,
  # or you can specify `age.identityPaths`.
in
{
  # Import ragenix module
  imports = [ inputs.ragenix.nixosModules.default ];

  # Configure ragenix
  age.secretsDir = ../secrets; # Directory where your encrypted .age files are stored (relative to this config file)
                               # So, create a directory named "secrets" next to your "modules" directory.

  # Define systemd service dependencies if secrets are needed early
  # services.my-service-that-needs-secrets.after = [ "ragenix-secrets.service" ];

  # Define individual secrets.
  # The name here ("wifi_M4WifiB_password") becomes part of the path where the decrypted secret is stored.
  # For example, /run/secrets/wifi_M4WifiB_password
  # The actual encrypted file should be located at ../secrets/wifi_M4WifiB_password.age
  # age.secrets.wifi_M4WifiB_password = {
  #   file = ../secrets/wifi_M4WifiB_password.age; # Path to the encrypted file
  #   owner = "root"; # Or a specific user if needed
  #   group = "root"; # Or a specific group like "networkmanager" if it needs to read it
  #   mode = "0440";  # Readable by owner and group
  # };

  # To make the ragenix CLI tool available on the system for encrypting new secrets:
  environment.systemPackages = [ pkgs.ragenix ];

  # To ensure the decryption keys are available to ragenix during system build/activation:
  # Option 1: Place your age private key(s) in /etc/ragenix/keys/ on the target machine.
  #           (Not recommended to store private keys directly in Nix config if public)
  # Option 2: Use SSH host keys (if encrypting to the host's SSH key). Ragenix might pick these up.
  # Option 3: Specify identity paths if your private key is elsewhere (e.g., user's SSH key if building as user)
  # age.identityPaths = [ "/home/vlekje/.ssh/id_ed25519" ]; # If building as vlekje and using vlekje's SSH key
  # For system-wide decryption during activation, the keys need to be accessible by root.
  # If you are building on one machine and deploying to another, ensure the target machine
  # has the necessary private keys (e.g., its own host SSH key if you encrypted to that).

  # For WiFi password, NetworkManager runs as root, so root owning the secret is fine.
  # If you use the systemd service to run `nmcli` as shown in networking.nix,
  # it will also run as root and can access the secret file.
}