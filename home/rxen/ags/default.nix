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
      gtk3
      gtk4
    ] ++ (with inputs.ags.packages.${pkgs.system}; [
      hyprland
      astal3
      mpris
      # network
      notifd
      # powerprofiles
      tray
      wireplumber
      inputs.astal.packages.${pkgs.system}.default
    ]);
  };
}
