{ inputs, ... }:
{

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      placement_strategy = "top";
      enable_audio_bell = false;
      include = "~/.cache/wal/colors-kitty.conf";
      font_size = "16.0";
      adjust_line_height = "3";
      cursor_blink_interval = "0";
      font_family = "Rxen Sans";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.9";
      cursor = "#82AAFF";
      window_padding_width = "10";
      enable_ligatures = "true";
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
        image_quality = 100;
        tab_size = 1;
        max_width = 1000;
        max_height = 1500;
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
