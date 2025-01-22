{ config, lib, pkgs, ... }: {
  home.packages = with pkgs;
    [ yt-dlp ani-cli ];
  programs.mpv = {
    enable = true;
    scripts = lib.mkIf pkgs.stdenv.isLinux [
      pkgs.mpvScripts.mpris
      pkgs.mpvScripts.uosc
      pkgs.mpvScripts.thumbfast
      pkgs.mpvScripts.sponsorblock
      pkgs.mpvScripts.youtube-upnext
    ];
    config = {
      profile = "high-quality";
      fullscreen = false;
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      cache-default = 4000000;
      osd-font = "Rxen Sans";
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      sub-auto = "fuzzy";
      sub-font = "Rxen Sans";
      sub-blur = 10;
      sub-pos = 90;
      sub-scale = 0.6;
      sub-file-paths = "subs:subtitles:字幕";
      screenshot-format = "png";
      title = "\${filename}";
      script-opts = "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";
      osd-duration = 750;
      osc = false;
      osd-bar = false;
      volume-max = 100;
    };
    scriptOpts = {
      uosc = {
        timeline_size = 30;
        volume_size = 30;
        timeline_style = "bar";
        timeline_persistency = "paused,audio";
        progress = "always";
        progress_size = 4;
        progress_line_width = 4;
        top_bar_title = true;
        top_bar_size = 60;
        top_bar_persistency = "paused,audio";
        refine = "text_width";
        opacity = "timeline=0.6,speed=0.6,title=0.0";
        disable_elements = "pause_indicator,controls";
        scale = 1;
        border_radius = 0;
        scale_fullscreen = 1;
        animation_duration = 0;
        stream_quality_options = "1080,720,480,360,240,144";
        top_bar_controls = false;
      };
      thumbfast = {
        spawn_first = true;
        network = true;
        hwdec = true;
      };
    };
    bindings = {
      "Tab" = "script-binding uosc/menu";
      n = "script-binding uosc/flash-volume; script-binding uosc/flash-timeline; script-binding uosc/flash-top-bar";
      a = "script-binding uosc/audio";
      s = "script-binding uosc/subtitles";
      c = "script-binding uosc/chapter";
      p = "script-binding uosc/playlist";

      m = "no-osd cycle    mute; script-binding uosc/flash-volume"; #! Audio > Mute
      k = "no-osd add volume  2; script-binding uosc/flash-volume"; #! Audio > Volume Up
      j = "no-osd add volume -2; script-binding uosc/flash-volume"; #! Audio > Volume Down

      h = "no-osd seek -5; script-binding uosc/flash-timeline";
      l = "no-osd seek 5; script-binding uosc/flash-timeline";


      o = "script-binding uosc/open-file";
      ">" = "script-binding uosc/next";
      "<" = "script-binding uosc/prev";


      "0" = "ignore";
      "1" = "ignore";
      "2" = "ignore";
      "3" = "ignore";
      "4" = "ignore";
      "5" = "ignore";
      "6" = "ignore";
      "7" = "ignore";
      "8" = "ignore";
      "9" = "ignore";
    };
  };
}
