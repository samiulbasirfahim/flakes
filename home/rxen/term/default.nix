{ config, ... }:
{

  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        include = "~/.cache/wal/colors-foot.ini";
        term = "screen-256color";
        font = "Rxen Sans:size=15";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        pad = "4x4 center";
        selection-target = "clipboard";
      };
      url = {
        protocols = "http, https, ftp, ftps, file, gemini, gopher";
      };
      colors = {
        alpha = ".9";
      };
      cursor = {
        style = "block";
      };
      key-bindings = { };
      mouse.hide-when-typing = "yes";
      tweak = {
        sixel = "yes";
      };
    };
  };



  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [
          1
          2
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}
