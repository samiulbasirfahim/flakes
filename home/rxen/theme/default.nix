{ pkgs, inputs, ... }:
{

  imports = [
    ./pywal.nix
  ];

  home.file.".local/share/fonts" = {
    enable = true;
    recursive = true;
    source = "${inputs.dotfiles}/fonts/.local/share/fonts";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 14;
  };

  # home.persistence."/nix/persist/home/rxen".directories = [
  #   ".cache/wal"
  #   ".config/wpg"
  #   ".themes"
  #   ".icons"
  #   ".local/share/themes"
  #   ".local/share/icons"
  # ];

  home.packages = with pkgs;
    [
      wpgtk
      xfce.thunar
      nwg-look
    ];

  programs.pywal16 = {
    enable = true;
    templates = {
      "discord.css" = ''
        /* customize things here */
        :root {{

        	/* background colors */
        	--bg-0: {background}; /* main background color. */
            --bg-1: #1d2021; /* background color for secondary elements like code blocks, embeds, etc. */
        	--bg-2: #3c3836; /* color of neutral buttons. */
        	--bg-3: #504945; /* color of neutral buttons when hovered. */


        	/* text colors */
        	--txt-dark: var(--bg-0); /* color of dark text on colored backgrounds. */
        	--txt-link: var(--aqua); /* color of links. */
        	--txt-0: {foreground}; /* color of bright/white text. */
        	--txt-1: {color1}; /* main text color. */
        	--txt-2: {color3}; /* color of secondary text like channel list. */
        	--txt-3: {color2}; /* color of muted text. */
        	/* mention/ping and message colors */
            --red: {color1};
            --green: {color2};
            --yellow: {color3};
            --blue: {color4};
            --purple: {color5};
            --aqua: {color1};
        }}
      '';
      "colors-hyprland.conf" = ''
        $wallpaper = {wallpaper}
        $background = rgb({background.strip})
        $foreground = rgb({foreground.strip})
        $color0 = rgb({color0.strip})
        $color1 = rgb({color1.strip})
        $color2 = rgb({color2.strip})
        $color3 = rgb({color3.strip})
        $color4 = rgb({color4.strip})
        $color5 = rgb({color5.strip})
        $color6 = rgb({color6.strip})
        $color7 = rgb({color7.strip})
        $color8 = rgb({color8.strip})
        $color9 = rgb({color9.strip})
        $color10 = rgb({color10.strip})
        $color11 = rgb({color11.strip})
        $color12 = rgb({color12.strip})
        $color13 = rgb({color13.strip})
        $color14 = rgb({color14.strip})
        $color15 = rgb({color15.strip})
      '';

      "colors-foot.ini" = ''
        [colors]
        background={background.strip}
        foreground={foreground.strip}
        regular0={color0.strip}
        regular1={color1.strip}
        regular2={color2.strip}
        regular3={color3.strip}
        regular4={color4.strip}
        regular5={color5.strip}
        regular6={color6.strip}
        regular7={color7.strip}
        bright0={color8.strip}
        bright1={color9.strip}
        bright2={color10.strip}
        bright3={color11.strip}
        bright4={color12.strip}
        bright5={color13.strip}
        bright6={color14.strip}
        bright7={color15.strip}
      '';
    };
  };


  gtk = {
    enable = true;
    theme.name = "FlatColor";
    font.name = "Rxen Sans";
    font.size = 12;
    iconTheme. name = "flattrcolor-dark";
  };
}
