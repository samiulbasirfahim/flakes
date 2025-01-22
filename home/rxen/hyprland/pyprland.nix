{ config, lib, pkgs, ... }:
let
  cfg = config.programs.pyprland;

  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.pyprland = {
    enable = lib.mkEnableOption "pyprland";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pyprland;
      defaultText = lib.literalExpression "pkgs.pyprland";
      description = "The package to use for the pypr binary";
    };

    settings =
      let
        t = lib.types;
        prim = t.either t.bool (t.either t.int t.str);
        primOrPrimAttrs = t.either prim (t.attrsOf prim);
        entry = t.either prim (t.listOf primOrPrimAttrs);
        entryOrAttrsOf = type: t.either entry (t.attrsOf type);
        entries = entryOrAttrsOf (entryOrAttrsOf entry);
      in
      lib.mkOption {
        type = lib.types.attrsOf entries;
        default = { };
        example = lib.literalExpression ''
          {
            pyprland = {
              plugins = [
                "scratchpads"
                "magnify"
              ];
            };

            "scratchpads.term" = {
              command = "kitty --class scratchpad";
              margin = 100;
            };
          }
        '';
      };
    description = ''
      Configuration written to
      {file}`$XDG_CONFIG_HOME/hypr/pyprland.toml`
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    wayland.windowManager.hyprland = {
      settings = { exec-once = [ "pypr" ]; };
    };

    xdg.configFile."hypr/pyprland.toml" = lib.mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "pyprland-config" cfg.settings;
    };
  };
}
