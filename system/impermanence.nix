{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  programs.fuse.userAllowOther = true;
  fileSystems."/nix".neededForBoot = true;

  system.activationScripts.createPersist = "mkdir -p /persist";

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories =
      [ "/etc/nixos" "/var/lib/" "/etc/NetworkManager/system-connections" ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = { mode = "u=rwx,g=,o="; };
      }
    ];
  };
}
