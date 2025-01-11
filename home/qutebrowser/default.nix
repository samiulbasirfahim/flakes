{ pkgs, ... }:
{
  home.file = {
    ".config/qutebrowser/config.py".source = ./config.py;
    ".config/qutebrowser/greasemonkey".source = ./greasemonkey;
    ".config/qutebrowser/pywalQute".source = ./pywalQute;
  };
  home.packages = [ pkgs.qutebrowser ];
}
