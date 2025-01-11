{ inputs, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../system
      inputs.disko.nixosModules.default
      (import ./../../lib/disko.nix)
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    initrd.kernelModules = [ "amdgpu" ];
  };


  networking.hostName = "hollow";
  time.timeZone = "Asia/Dhaka";

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
