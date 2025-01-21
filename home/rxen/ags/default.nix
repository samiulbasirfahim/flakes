{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];


  home.persistence."/nix/persist/home/rxen".directories = [
    ".config/ags"
  ];
  programs.ags = {
    enable = true;

    # configDir = ./config;

    extraPackages = with pkgs; [

    ];
  };
}
