{ pkgs, ... }: {
  home.packages = [ pkgs.picom ];
  home.file.".config/picom/picom.conf".text = ''
    backend = "glx"
  '';
}
