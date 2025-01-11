{ config, pkgs, user, ... }: {
  imports = [
    ./impermanence.nix
    ./desktop.nix
    ./user.nix
    ./virtualization.nix
  ];


  services.getty.autologinUser = "${user}";

  systemd = {
    packages = [ pkgs.cloudflare-warp ];
    services."warp-svc".wantedBy = [ "multi-user.target" ];
    user.services."warp-taskbar".wantedBy = [ "tray.target" ];
  };

  environment = {
    systemPackages = with pkgs; [
      cloudflare-warp
      ripgrep
      wget
      libcxxStdenv
      clang
      gcc
      unzip
    ];
    shells = with pkgs; [ zsh ];
    sessionVariables = { TZ = "${config.time.timeZone}"; };
  };


  programs.nano.enable = false;


  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performancee";
  };


  services.udev.extraRules = ''
    KERNEL=="card0", SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';
  services.gvfs.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };


  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnsupportedSystem = true;
      allowUnfree = true;

    };
    overlays =
      let
        myOverlay = self: super: {
          qutebrowser = super.qutebrowser.override { enableWideVine = true; };
        };
      in
      [
        myOverlay
      ];
  };

}
