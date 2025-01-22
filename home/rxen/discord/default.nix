{ pkgs, ... }:

let
  pywal_discord = pkgs.writeShellScriptBin "pywal-discord" ''
    #!/usr/bin/env bash
    echo "
    @import url('https://refact0r.github.io/system24/src/main.css'); /* main theme css. DO NOT REMOVE */
    @import url('https://refact0r.github.io/system24/src/unrounding.css'); /* gets rid of all rounded corners. remove if you want rounded corners. */


    :root {
    	--font: 'Rxen Sans'; /* UI font name. it must be installed on your system. */
    	letter-spacing: -0.05ch; /* decreases letter spacing for better readability. */
    	font-weight: 400; /* UI font weight. */
    	--label-font-weight: 500; /* font weight for panel labels. */
    	--pad: 16px; /* padding between panels. */
    	--txt-pad: 10px; /* padding inside panels to prevent labels from clipping */
    	--panel-roundness: 0px; /* corner roundness of panels. ONLY WORKS IF unrounding.css IS REMOVED (see above). */


    	/* state modifiers */
    	--hover: color-mix(in oklch, var(--txt-3), transparent 80%); /* color of hovered elements. */
    	--active: color-mix(in oklch, var(--txt-3), transparent 60%); /* color of elements when clicked. */
    	--selected: var(--active); /* color of selected elements. */

    	--mention-txt: var(--acc-0); /* color of mention text. */
    	--mention-bg: color-mix(in oklch, var(--acc-0), transparent 90%); /* background highlight of mention text. */
    	--mention-overlay: color-mix(in oklch, var(--acc-0), transparent 90%); /* overlay color of messages that mention you. */
    	--mention-hover-overlay: color-mix(in oklch, var(--acc-0), transparent 95%); /* overlay color of messages that mention you when hovered. */
    	--reply-overlay: var(--active); /* overlay color of message you are replying to. */
    	--reply-hover-overlay: var(--hover); /* overlay color of message you are replying to when hovered. */



    	/* accent colors */
    	--acc-0: var(--aqua); /* main accent color. */
    	--acc-1: var(--green); /* color of accent buttons when hovered. */
    	--acc-2: var(--blue); /* color of accent buttons when clicked. */

    	/* borders */
    	--border-width: 2px; /* panel border thickness. */
    	--border-color: var(--bg-2); /* panel border color. */
    	--border-hover-color: var(--acc-0); /* panel border color when hovered. */
    	--border-transition: 0.2s ease; /* panel border transition. */

        /* status dot colors */
    	--online-dot: green; /* color of online dot. */
    	--dnd-dot: red; /* color of do not disturb dot. */
    	--idle-dot: yellow; /* color of idle dot. */
    	--streaming-dot: purple; /* color of streaming dot. */
    }" > /tmp/pywal-discord

    mkdir -p "$HOME/.config/Vencord/themes"
    cat "/tmp/pywal-discord" "$HOME/.cache/wal/discord.css" > "$HOME/.config/Vencord/themes/tui.css"
  '';
in
{


  # home.persistence."/nix/persist/home/rxen".directories = [
  #   ".config/discord"
  #   ".config/Vencord"
  # ];


  home.packages = with pkgs;
    [
      pywal_discord
      (discord.override {
        # withOpenASAR = true; # can do this here too
        withVencord = true;
      })
    ];

}
