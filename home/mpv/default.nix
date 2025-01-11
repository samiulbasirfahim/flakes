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
      sub-file-paths = "subs:subtitles:字幕";
      screenshot-format = "png";
      title = "\${filename} - mpv";
      script-opts = "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";
      osd-duration = 750;
      osc = false;
      osd-bar = false;
    };
    scriptOpts = {
      uosc = {
        timeline_size = 25;
        timeline_persistency = "paused,audio";
        progress = "always";
        progress_size = 4;
        progress_line_width = 4;
        controls = "subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality";
        top_bar = "never";
        refine = "text_width";
      };
      thumbfast = {
        spawn_first = true;
        network = true;
        hwdec = true;
      };
    };
    bindings = {
      n = ''show-text ''${media-title}'';
      a = "script-binding uosc/menu";
      c = "script-binding uosc/stream-quality";
      s = "script-binding uosc/subtitles";

      "h" = "seek -5";
      "l" = "seek 5";
      "j" = "add volume -5";
      "k" = "add volume 5";
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
