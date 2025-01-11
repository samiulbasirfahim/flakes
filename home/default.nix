{ inputs, self, user, ... }: {
  imports = with inputs;[
    home-manager.nixosModules.home-manager
  ];
  home-manager = {
    backupFileExtension = "bkp";
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user self; };
    users.${user} = {
      imports = [
        ./git
        ./gtk
        ./pywal
        ./btop
        ./zsh
        ./xdg
        ./picom
        ./qutebrowser
        ./firefox
        ./neovim
        ./emacs
        ./nsxiv
        ./mpv
        ./spotify
        ./discord
        ./languages/rust.nix
        inputs.impermanence.homeManagerModules.impermanence
      ];
      home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "24.11";
        sessionPath = [ "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/" ];
      };
      programs.home-manager.enable = true;
    };
  };
}
