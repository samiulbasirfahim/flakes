{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];


  # home.persistence."/nix/persist/home/rxen".directories = [
  #   ".config/ags"
  # ];
  programs.ags = {
    enable = true;

    # configDir = ./config;

    extraPackages = with pkgs; [
      gtk3
      gtk4
      dart-sass
    ] ++ (with inputs.ags.packages.${pkgs.system}; [
      hyprland
      astal3
      mpris
      network
      notifd
      # powerprofiles
      apps
      tray
      wireplumber
      inputs.astal.packages.${pkgs.system}.default
    ]);
  };
}
