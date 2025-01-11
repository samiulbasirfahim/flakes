{
  programs.emacs.enable = true;
  services.emacs.enable = true;
  home.file.".emacs.d" = {
    source = ./config;
    recursive = true;
  };
}
