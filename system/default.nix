{ inputs, pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./user.nix
    ./impermanence.nix
    # ./stylix.nix
  ];

  systemd = {
    packages = [ pkgs.cloudflare-warp ];
    services."warp-svc".wantedBy = [ "multi-user.target" ];
    user.services."warp-taskbar".wantedBy = [ "tray.target" ];
  };

  environment.systemPackages = with pkgs;[
    cloudflare-warp
    libcxxStdenv
    clang
    gcc
    git
    curl
    neovim
    unzip
    nixd
    libnotify
    kitty
    xorg.xrdb
    st
  ];

  fonts.packages = [
    pkgs.dejavu_fonts
    pkgs.nerd-fonts.symbols-only
    pkgs.nerd-fonts.iosevka-term-slab
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (self: super: {
      st = super.st.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = " samiulbasirfahim ";
          repo = "st";
          rev = "926ad9f29b179bd5fe16f4e07dbdcec83def6785";
          hash = "sha256-hwX1XhSX8KhXHROuKLEMzdYtd86/aMsetIycPLN0l2I=";
        };
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.harfbuzz ];
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
      });
    })
  ];


  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  services.gvfs.enable = true;
  programs.nano.enable = false;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performancee";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="pci", DRIVER=="amdgpu", ATTR{power_dpm_force_performance_level}="high"
  '';
}
