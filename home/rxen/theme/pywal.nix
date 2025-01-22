{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (lib) types literalExpression;
  cfg = config.programs.pywal16;
in
{
  options.programs.pywal16 = {
    enable = mkEnableOption "pywal16";

    package = mkOption {
      type = types.package;
      default = pkgs.pywal16;
      defaultText = literalExpression "pkgs.pywal16";
      description = "The package to use for pywal16";
    };

    templates = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Custom templates for pywal16";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];

    home.file = builtins.foldl'
      (acc: set: acc // {
        ".config/wal/templates/${set.name}".text = set.value;
      })
      { }
      (lib.attrsToList cfg.templates);
  };
}
