{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "SamiulBasirFahim";
    userEmail = "samiulbasirfahim.rxen@gmail.com";
  };

  # home.persistence."/nix/persist/home/rxen" = {
  #   directories = [
  #     ".config/gh"
  #   ];
  # };
  home.packages = with pkgs;[
    gh
    lazygit
  ];
}
