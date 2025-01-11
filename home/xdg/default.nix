{ pkgs, ... }: {
  home.packages = with pkgs; [ xdg-utils ];
  xdg.userDirs = {
    enable = true;
    desktop = "$HOME";
    download = "$HOME/Downloads";
    documents = "$HOME/docs";
    pictures = "$HOME/pix";
    videos = "$HOME/vids";
    templates = "$HOME";
  };
}
