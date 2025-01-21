{ inputs, self, pkgs, ... }:
let
  user = "rxen";
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "f4h1m";
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs user self; };
    users."${user}" = import ../home/${user};
  };

  services.getty.autologinUser = "${user}";

  systemd.services.persistence-folder = {
    script = ''
      mkdir -p /nix/persist/home/${user}
      chown ${user} /nix/persist/home/${user}
    '';
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
