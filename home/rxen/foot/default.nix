{ inputs, ... }:
{
  home.file.".local/share/fonts" = {
    enable = true;
    recursive = true;
    source = "${inputs.dotfiles}/fonts/.local/share/fonts";
  };
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        # horizontal-letter-offset = 0;
        # vertical-letter-offset = 0;
        pad = "4x4";
        selection-target = "clipboard";
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
        indicator-position = "relative";
        indicator-format = "line";
      };
      cursor = {
        style = "beam";
        beam-thickness = 1;
      };
    };
  }; 
}
