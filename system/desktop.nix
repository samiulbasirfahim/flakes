{ pkgs, inputs, ... }:
let
  layoutmenu = pkgs.writeShellScriptBin "_dmw_layoutmenu" ''
    #!/bin/env bash

    LAYOUT="$(echo -e "  Tiled Layout\n  Floating Layout\n  Monocle Layout\n  Centered Master\n  Centered Floating\n  Grid Layout\n  Bottom Stack Layout\n󰯌  Deck Layout" | dmenu -c -m 0)"

    [[ $LAYOUT == "  Tiled Layout" ]] && echo 0
    [[ $LAYOUT == "  Floating Layout" ]] && echo 1
    [[ $LAYOUT == "  Monocle Layout" ]] && echo 2
    [[ $LAYOUT == "  Centered Master" ]] && echo 3
    [[ $LAYOUT == "  Centered Floating" ]] && echo 4
    [[ $LAYOUT == "  Grid Layout" ]] && echo 5
    [[ $LAYOUT == "  Bottom Stack Layout" ]] && echo 6
    [[ $LAYOUT == "󰯌  Deck Layout" ]] && echo 7
  '';
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    #!/bin/env bash
    
    case "$(echo -e "Shutdown\nRestart\nLock\nLogout" | dmenu -c -l 5 -m 0)" in
            Shutdown) exec systemctl poweroff;;
            Restart) exec systemctl reboot;;
            Logout) exec loginctl kill-session self;;
            Lock) exec betterlockscreen -l blur;;
    esac

  '';
  screenshot_dmenu = pkgs.writeShellScriptBin "screenshot_dmenu" ''
    #!/bin/env bash

    SCSH_FORMAT="$(date +%Y-%m-%d_%T).png"
    SCSH_DIR="$HOME/pix/screenshots/"

    mkdir -p $SCSH_DIR

    CAP_OPTS=" screen\n󱂬 window\n󰋃 selection"

    SCHSH_CAP=$(echo -e $CAP_OPTS | dmenu -c -m 0)
    [[ -z $SCHSH_CAP ]] && echo "screenshot aborted" && exit 0


    [[ $SCHSH_CAP == " screen" ]] && maim $SCSH_DIR/$SCSH_FORMAT && notify-send "ScreenShot" "Screen saved to $SCSH_DIR"
    [[ $SCHSH_CAP == "󱂬 window" ]] && maim -i $(xdotool getactivewindow) $SCSH_DIR/$SCSH_FORMAT && notify-send "ScreenShot" "Current window to $SCSH_DIR"
    [[ $SCHSH_CAP == "󰋃 selection" ]] && maim -s $SCSH_DIR/$SCSH_FORMAT && notify-send "ScreenShot" "Selected area saved to $SCSH_DIR"
  '';
  screenshot_dmenu_c = pkgs.writeShellScriptBin "screenshot_dmenu_c" ''
    #!/bin/env bash

    SCSH_FORMAT="$(date +%Y-%m-%d_%T).png"
    SCSH_DIR="$HOME/pix/screenshots/"

    mkdir -p $SCSH_DIR

    CAP_OPTS=" screen\n󱂬 window\n󰋃 selection"

    SCHSH_CAP=$(echo -e $CAP_OPTS | dmenu -c -m 0)
    [[ -z $SCHSH_CAP ]] && echo "screenshot aborted" && exit 0


    [[ $SCHSH_CAP == " screen" ]] &&  maim | xclip -selection clipboard -t image/png && notify-send "ScreenShot" "Screen copied to clipboard"
    [[ $SCHSH_CAP == "󱂬 window" ]] && maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png && notify-send "ScreenShot" "Current window copied to clipboard"
    [[ $SCHSH_CAP == "󰋃 selection" ]] && maim -s | xclip -selection clipboard -t image/png && notify-send "ScreenShot" "Selected area copied to clipboard"
  '';
  launcher = pkgs.writeShellScriptBin "launcher" ''
    cachedir=~/.cache/
    if [ -d "$cachedir" ]; then
    	cache=$cachedir/dmenu_run
    	historyfile=$cachedir/dmenu_history
    fi

    IFS=:
    if stest -dqr -n "$cache" $PATH; then
    	stest -flx $PATH | sort -u > "$cache"
    fi
    unset IFS

    awk -v histfile=$historyfile '
    	BEGIN {
    		while( (getline < histfile) > 0 ) {
    			sub("^[0-9]+\t","")
    			print
    			x[$0]=1
    		}
    	} !x[$0]++ ' "$cache" \
    	| dmenu -m 0 "$@" \
    	| awk -v histfile=$historyfile '
    		BEGIN {
    			FS=OFS="\t"
    			while ( (getline < histfile) > 0 ) {
    				count=$1
    				sub("^[0-9]+\t","")
    				fname=$0
    				history[fname]=count
    			}
    			close(histfile)
    		}

    		{
    			history[$0]++
    			print
    		}

    		END {
    			if(!NR) exit
    			for (f in history)
    				print history[f],f | "sort -t '\t' -k1rn >" histfile
    		}
    	' \
    	| while read cmd; do "$cmd" & done
  '';

  dwmblocks_weather = pkgs.writeShellScriptBin "_dwmbar_weather" ''
    colors_path=$HOME/.cache/wal/colors.sh

    WEATHER=$(curl --silent v2d.wttr.in/dhaka | grep "Weather:")
    TEMP=$(echo $WEATHER | tr "," "\n" | grep "°C")

    if [ -f "$colors_path" ]; then
        source $colors_path
        [[ ! -z "$TEMP" ]] && echo "^b$color1^^c$color0^  ^d^^b$color8^^c$color0^$TEMP ^d^"
    fi
  '';
  dwmblocks_cpu = pkgs.writeShellScriptBin "_dwmbar_cpu" ''
    colors_path=$HOME/.cache/wal/colors.sh
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

    # cpu_usage=$(echo "$cpu_usage" | cut -c1-1)
    cpu_usage=$(printf "%.0f" "$cpu_usage")

    if [ -f "$colors_path" ]; then
      source $colors_path
      echo "^b$color1^^c$color0^  ^d^^b$color8^^c$color0^ $cpu_usage% ^d^"
    fi
  '';
  dwmblocks_memory = pkgs.writeShellScriptBin "_dwmbar_memory" ''
    colors_path=$HOME/.cache/wal/colors.sh
    memory_usage=$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)

    if [ -f "$colors_path" ]; then
      source $colors_path
      echo "^b$color1^^c$color0^  ^d^^b$color8^^c$color0^ $memory_usage ^d^"
    fi
  '';
  dwmblocks_date = pkgs.writeShellScriptBin "_dwmbar_date" ''
    colors_path=$HOME/.cache/wal/colors.sh
    if [ -f "$colors_path" ]; then
      source $colors_path
      echo "^c$color0^^b$color1^$(date +" %d") ^d^^c$color0^^b$color8^$(date +" %I:%M%p") ^d^ ^d^ "
    fi
  '';
in
{
  programs.dconf.enable = true;
  fonts.packages = [
    pkgs.nerd-fonts.symbols-only
  ];



  environment.systemPackages = with pkgs;[
    dwmblocks_weather
    dwmblocks_memory
    dwmblocks_cpu
    dwmblocks_date
    screenshot_dmenu
    screenshot_dmenu_c
    powermenu
    layoutmenu
    launcher
    maim
    st
    dmenu
    nemo
    dwmblocks
    xsel
    xclip
    nsxiv
    pulsemixer
    xdotool
    xwallpaper
    libnotify
    wired
    haskellPackages.greenclip
  ];


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal ];
    config.common.default = "*";
  };



  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''Option "TearFree" "true"'';
    windowManager.dwm.enable = true;
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };



  nixpkgs = {
    overlays =
      let
        myOverlay = self: super: {
          dwm = super.dwm.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
              owner = "samiulbasirfahim";
              repo = "dwm";
              rev = "main";
              hash = "sha256-Gog7a6F4AmZ9A8B5nJ+IYpTZj+J4/f0xt8iZSsylmF0=";
            };
            buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.imlib2 ];
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
          });


          st = super.st.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
              owner = " samiulbasirfahim ";
              repo = "st";
              rev = "master";
              hash = "sha256-BVDVnJsa3V98tyTJtLv0ixLRUrTtr0nbqOewystGfu4=";
            };
            buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.harfbuzz ];
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
          });


          dwmblocks = super.dwmblocks.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
              owner = " samiulbasirfahim ";
              repo = "dwmblocks";
              rev = "main";
              hash = "sha256-ev1tNQQnG6xKX51D3mJ9Bm2tlZCjJdhd39DAgfLUw+Q=";
            };

            propagatedBuildInputs = [
            ];
            buildInputs = (old.buildInputs or [ ]) ++ [ ];
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
          });


          dmenu = super.dmenu.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
              owner = "samiulbasirfahim";
              repo = "dmenu";
              rev = "c16224be16ff58f75d8df42111fad9ff11840cb2";
              hash = "sha256-naFi7ShzZ5rHAk1OHA580zcIgGSTyvLz7G4fj+fxvOU=";
            };
            NIX_CFLAGS_COMPILE = "-lXrender -lm";
            buildInputs = with pkgs; (old.buildInputs or [ ]) ++ [ ];
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
          });

        };
      in
      with inputs;      [
        myOverlay
        nur.overlays.default
      ];
  };
}
