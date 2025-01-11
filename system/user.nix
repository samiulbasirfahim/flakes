{ pkgs, ... }: {
  imports = [ ../home ];
  users.users.rxen = {
    isNormalUser = true;
    initialPassword = "f4h1m";
    extraGroups = [ "wheel" ];
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
