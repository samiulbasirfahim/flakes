{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "SamiulBasirFahim";
    userEmail = "samiulbasirfahim.rxen@gmail.com";
  };
  home.packages = with pkgs;[
    gh
    lazygit
  ];
}
