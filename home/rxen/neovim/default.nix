{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.file.".config/nvim" = {
    source = ./config;
    enable = true;
    recursive = true;
  };

  home.packages = with pkgs;
    [
      ripgrep
      cargo
      nodejs
      nixd
    ];

  home.persistence."/nix/persist/home/rxen".directories = [
    ".config/nvim/"
    ".local/share/nvim"
    ".local/state/nvim"
  ];
}
