{ pkgs, ... }: {
  # home.persistence."/nix/persist/home/rxen".files = [
  #   ".cache/zsh_history"
  # ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchDownKey = "^N";
      searchUpKey = "^P";
    };

    history = {
      share = true;
      size = 10000;
      save = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    initExtra = ''
      ${(builtins.readFile ./config/functions.zsh)}
      ${(builtins.readFile ./config/plugins.zsh)}
      ${(builtins.readFile ./config/config.zsh)}

      if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
          exec Hyprland
      fi
    '';

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /nix/persist/home/rxen/dev/flakes/#hollow";
      ls = "${pkgs.eza}/bin/eza -l --icons=always";
      lsa = "${pkgs.eza}/bin/eza -la --icons=always";
      lst = "${pkgs.eza}/bin/eza -T --icons=always";
      lsta = "${pkgs.eza}/bin/eza -Ta --icons=always";
      ip = "ip --color";
      ipb = "ip --color --brief";
    };
  };
}
