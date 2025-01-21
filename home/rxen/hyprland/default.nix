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

  # stylix.targets.hyprpaper.enable = lib.mkForce false;


  home.persistence."/nix/persist/home/rxen".directories = [
    ".cache/cliphist"
    ".cache/swww"
  ];

  home.packages = with pkgs;
    [
      swww
      wl-clipboard
      cliphist
      nemo
      dolphin
    ];

  services.cliphist.enable = true;


  wayland.windowManager.hyprland =
    {
      enable = true;
      settings = {

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
          border_size = 2;
          # "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base08})";
          # "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base00}00)";
          allow_tearing = true;
          resize_on_border = true;
          layout = "master";
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
          enabled = true;
          bezier = [ "overshot, 0.13, 0.99, 0.29, 1.1" ];
          animation = [
            "windows, 1, 4, overshot, slide"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 5, default"
            "fade, 1, 8, default"
            "workspaces, 1, 6, overshot, slidevert"
          ];
        };
        "$mod" = "${mod}";

        bind = [
          "$mod, Return, exec, kitty -1"
          "$mod, Q, killactive"
          "$mod, F, fullscreen"
          "$mod, Space, togglefloating"
          "$mod, S, pin"

          "$mod SHIFT, Return, layoutmsg, swapwithmaster master"

          "$mod, J, layoutmsg, cyclenext"
          "$mod, K, layoutmsg, cycleprev"
        ] ++ workspaces;

        binde = [
          "$mod SHIFT, H, splitratio, -0.025"
          "$mod SHIFT, L, splitratio, +0.025"
        ];

        bindm = [
          "$mod, mouse:273, resizewindow"
          "$mod, mouse:272, movewindow"
        ];

        exec-once = [
          "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
          "swww-daemon"
        ];
      };
    };


  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
