{ pkgs, lib, user, config, ... }:
let
  inherit (pkgs) python3;
  colorz = python3.pkgs.buildPythonPackage {
    inherit (pkgs.colorz) name version src propagatedBuildInputs meta;
  };
  pywal-colorz = pkgs.pywal.overrideAttrs (orig: {
    version = "9999";

    propagatedBuildInputs = [
      colorz
    ];

    src = pkgs.fetchgit {
      url = "https://github.com/dylanaraps/pywal.git";
      rev = "236aa48e741ff8d65c4c3826db2813bf2ee6f352";
      hash = "sha256-La6ErjbGcUbk0D2G1eriu02xei3Ki9bjNme44g4jAF0=";
    };

    patches = [
      ./pywal-backends.patch
    ];
  });

  set_wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    if [ -f "$1" ]; then
        xwallpaper --zoom "$1" &
        xwallpaper --output  DisplayPort-0 --stretch "$1" &
        betterlockscreen -u "$1" --fx blur &
        echo "$1" >~/.local/share/default_wallpaper &
        wal --backend wal -nqti "$1" && reload &
    else
        wp="$(find $HOME/pix/wallpapers -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.JPG" | nsxiv -tio -N 'wallpaper-menu' -g '1440x740' | sed 's/^\(.*\)$/"\1"/' | xargs -r -n 1)"
        if [ -f "$wp" ]; then
            xwallpaper --zoom "$wp" &
            xwallpaper --output  DisplayPort-0 --stretch "$wp" &
            betterlockscreen -u "$wp" --fx blur &
            echo "$wp" >~/.local/share/default_wallpaper &
            wal --backend wal -nqti "$wp" && reload &
        fi
    fi '';

  load_wallpaper = pkgs.writeShellScriptBin "load-wallpaper" ''
    wp="$(cat ~/.local/share/default_wallpaper)"
    xwallpaper --zoom "$wp" &
    wal --backend wal -nqti "$wp" && reload &
  '';
  reload = pkgs.writeShellScriptBin "reload" ''
    cat ~/.cache/wal/colors.Xresources > ~/.Xresources &
    mkdir ~/.config/wired/ &
    ln -sf ~/.cache/wal/wired ~/.config/wired/wired.ron &

    xrdb load ~/.Xresources
    xdotool key Super+F5 &

    pkill dwmblocks
    setsid dwmblocks &

    pywal-discord &
    pywalfox update &
    # # spicetify apply &
    #
    # zathura-pywal -a 0.95 &
  '';
in
{
  home.packages = [
    # pywal-colorz
    set_wallpaper
    load_wallpaper
    reload
    pkgs.pywal
    pkgs.jq
    pkgs.pywalfox-native
  ];


  home.activation.installPywalfox = lib.hm.dag.entryAfter [ "writeBoundary" ]
    ''
      #!/usr/bin/env bash
      ${pkgs.pywalfox-native}/bin/pywalfox install
    '';

  home.file.".config/wal/templates/wired".source = ./wired;
  home.file.".config/wal/templates/discord.css".source = ./discord.css;

  home.file.".local/bin/waldl" = {
    source = ./waldl;
    executable = true;
  };

}
