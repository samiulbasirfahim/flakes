{ inputs, user, ... }:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];
  home.persistence."/nix/persist/home/${user}" = {
    directories = [
      "dev"
      "vids"
      "pix"
      "Downloads"
      ".mozilla"
      ".ssh"
    ];
    files = [
    ];
    allowOther = true;
  };
}
