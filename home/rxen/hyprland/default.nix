{ pkgs, inputs, config, lib, ... }:
let
  mod = "Super";
  workspaces = builtins.concatLists (builtins.genList
    (x:
      let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10)); in [
        "${mod}, ${ws}, workspace, ${toString (x + 1)}"
        "${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ])
    10);
in
{


  # home.persistence."/nix/persist/home/rxen".directories = [
  #   ".cache/cliphist"
  #   ".cache/swww"
  # ];

  imports = [ ./pyprland.nix ];

  home.packages = with pkgs;
    [
      swww
      wl-clipboard
      cliphist
      nemo
      hyprprop
    ];

  services.cliphist.enable = true;


  wayland.windowManager.hyprland =
    {
      enable = true;
      settings = {
        source = "~/.cache/wal/colors-hyprland.conf";

        monitor = [
          ", highrr, auto, 1"
        ];


        input = {
          kb_layout = "us";
          repeat_rate = 50;
          repeat_delay = 300;

          accel_profile = "flat";
          follow_mouse = 1;
          sensitivity = 0;
          mouse_refocus = false;
        };

        general = {
          gaps_in = 6;
          gaps_out = 12;
          border_size = 3;
          "col.active_border" = "$color1";
          "col.inactive_border" = "rgba(00000000)";
          allow_tearing = true;
          resize_on_border = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_autoreload = true;
          force_default_wallpaper = 0;
          animate_mouse_windowdragging = false;
          swallow_regex = "^(Alacritty|kitty|footclient|foot)$";
          enable_swallow = true;
          vrr = 1;
        };

        master = {
          new_on_top = true;
          new_status = "master";
          mfact = 0.55;
          special_scale_factor = 1;
        };

        xwayland.force_zero_scaling = true;
        debug.disable_logs = false;

        decoration = {
          rounding = 0;
          blur = {
            enabled = true;
            passes = 1;
            size = 3;
            popups = true;
            popups_ignorealpha = 0.2;
          };

          shadow.enabled = false;
        };


        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 4, myBezier"
            "windowsOut, 1, 4, default, popin 80%"
            "border, 1, 3, default"
            "fade, 1, 4, default"
            "workspaces, 1, 4, default"
          ];

          # enabled = true;
          # bezier = [ "overshot, 0.13, 0.99, 0.29, 1.1" ];
          # animation = [
          #   "windows, 1, 4, overshot, slide"
          #   "windowsOut, 1, 5, default, popin 80%"
          #   "border, 1, 5, default"
          #   "fade, 1, 8, default"
          #   "workspaces, 1, 6, overshot, slidevert"
          # ];
        };


        "$mod" = "${mod}";

        bind = [
          "$mod, Return, exec, st"
          "$mod, Z, exec, ags toggle launcher"
          "$mod, Q, killactive"
          "$mod, F, fullscreen"
          "$mod, Space, togglefloating"
          "$mod, S, pin"


          "$mod, Escape, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
          "$mod, E, exec, pypr toggle yazi && hyprctl dispatch bringactivetotop"
          "$mod, T, exec, pypr toggle btop && hyprctl dispatch bringactivetotop"
          "$mod, A, exec, pypr toggle pulsemixer && hyprctl dispatch bringactivetotop"
          # "$shiftMod, W, exec, pypr toggle waypaper && hyprctl dispatch bringactivetotop"
          # "$shiftMod, S, exec, pypr toggle spotify && hyprctl dispatch bringactivetotop"

        ] ++ workspaces;

        binde = [
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          "$mod CTRL, l, resizeactive, 20 0"
          "$mod CTRL, h, resizeactive, -20 0"
          "$mod CTRL, k, resizeactive, 0 -20"
          "$mod CTRL, j, resizeactive, 0 20"

          "$mod, n, workspace, e+1"
          "$mod, p, workspace, e-1"
        ];

        bindm = [
          "$mod, mouse:273, resizewindow"
          "$mod, mouse:272, movewindow"
        ];


        "$scratchpad_float" = "title:^(scratchpad.float)$";
        "$waypaper" = "class:^(waypaper)$";
        "$spotify" = "title:^(Spotify Premium)$";
        "$networkmanager" = "class:^(nm-connection-editor)$";
        "$blueman" = "class:^(.blueman-manager-wrapped)$";

        windowrulev2 = [
          "float, $scratchpad_float"
          "center, $scratchpad_float"

          "float, $spotify"
          "workspace special silent, $spotify"
          "center, $spotify"

          "float, $waypaper"
          "workspace special silent, $waypaper"
          "center, $waypaper"
        ];
        exec-once = [
          "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
          "swww-daemon"
          "xrdb load ~/.cache/wal/colors.Xresources"
          "ags run ~/.config/ags/ags"
        ];
      };
    };




  programs.pyprland = {
    enable = true;

    settings = {
      pyprland = { plugins = [ "scratchpads" ]; };

      scratchpads = {
        term = {
          class = "scratchpad.term";
          lazy = true;
          animation = "fromTop";
          command = "foot --title=scratchpad.float";
          margin = 200;
          size = "85% 70%";
        };
        yazi = {
          class = "scratchpad.yazi";
          lazy = true;
          animation = "fromTop";
          command = "foot --title=scratchpad.float -e yazi";
          margin = 200;
          size = "85% 70%";
        };
        btop = {
          class = "scratchpad.btop";
          lazy = true;
          animation = "fromTop";
          command = "st --title=scratchpad.float -e btop -g 30:20";
          margin = 200;
        };
        pulsemixer = {
          lazy = true;
          animation = "fromTop";
          command = "foot --title=scratchpad.float -e pulsemixer";
          margin = 200;
          size = "85% 70%";
        };
        waypaper = {
          lazy = true;
          class = "waypaper";
          animation = "fromTop";
          command = "waypaper";
          margin = 200;
          size = "85% 70%";
        };
      };
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
