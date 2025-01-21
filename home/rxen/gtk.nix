{ pkgs, config, inputs, lib, ... }:
{


  home.file.".local/share/fonts" = {
    enable = true;
    recursive = true;
    source = "${inputs.dotfiles}/fonts/.local/share/fonts";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 14;
  };

  home.persistence."/nix/persist/home/rxen".directories = [
    ".cache/wal"
    ".config/wpg"
    ".themes"
    ".icons"
    ".local/share/themes"
    ".local/share/icons"
  ];

  home.packages = with pkgs;
    [
      wpgtk
      nwg-look
      pywal
    ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      # package = pkgs.papirus-icon-theme;
    };
  };
}
