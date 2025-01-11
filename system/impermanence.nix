{ inputs, user, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  programs.fuse.userAllowOther = true;

  fileSystems."/nix".neededForBoot = true;
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
    users.${user} = {
      directories = [
        "dev"
        "docs"
        "vids"
        "pix"
        "Downloads"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }

        ".config"
        ".cache"
        ".cargo"
        ".rustup"
        ".local"
        ".emacs.d"
        ".mozilla"
      ];
      files = [ ".xinitrc" ".Xresources" ];
    };
  };
}
