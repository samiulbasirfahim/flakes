{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    llvmPackages_19.clang-tools
    cppcheck
  ];
  home.file.".config/nvim" = {
  	source = ./config;
	enable = true;
	recursive =  true;
  };
}
