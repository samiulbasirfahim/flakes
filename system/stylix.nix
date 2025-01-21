{ inputs, pkgs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    enable = true;
    image = ../home/rxen/hyprland/wallhaven-5gx2q5.png;
    polarity = "dark";

    opacity.terminal = 0.9;
    opacity.popups = 0.9;

    cursor = {
      package = pkgs.vimix-cursors;
      name = "Vimix-white-cursors";
      size = 14;
    };

    fonts = {
      sizes = {
        applications = 11;
        terminal = 14;
        desktop = 12;
        popups = 11;
      };

      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "Rxen Sans";
      };

      serif = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "Rxen Sans";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "Rxen Sans";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

    };
  };
}
