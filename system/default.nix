{ inputs, pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./user.nix
    ./impermanence.nix
    ./stylix.nix
  ];

  environment.systemPackages = with pkgs;[
    gcc
    git
    curl
    neovim
    unzip
    nixd
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  programs.nano.enable = false;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performancee";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="pci", DRIVER=="amdgpu", ATTR{power_dpm_force_performance_level}="high"
  '';
}
