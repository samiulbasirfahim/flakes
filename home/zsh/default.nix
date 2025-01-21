{ pkgs, ... }: {
  home.packages = [ pkgs.zoxide pkgs.eza pkgs.fd pkgs.fzf ];
  home.file.".config/zsh".source = ./config;
  programs.zsh = {
    enable = true;
    autocd = true;
    initExtra = ''source ~/.config/zsh/init.zsh'';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /nix/persist/home/rxen/dev/flakes/#hollow";
    };
    dirHashes = {
      docs = "$HOME/docs";
      notes = "$HOME/docs/notes";
      dots = "$HOME/dev/flakes";
      dl = "$HOME/downloads";
      vids = "$HOME/vids";
      pix = "$HOME/pix";
      media = "/run/media/$USER";
    };
  };
}
