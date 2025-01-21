{ inputs, self, user, ... }: {
  imports = [
    ./hyprland
    ./foot
    ./neovim
    ./btop
    ./ags
    ./impermanence.nix
    ./git.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";
    sessionPath = [ "$HOME/.cargo/bin" ];
  };
  programs.home-manager.enable = true;
}
