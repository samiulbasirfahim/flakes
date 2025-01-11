{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    hardened-firefox = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      selfPkgs = import ./pkgs;
      system = "x86_64-linux";
      user = "rxen";
      inherit nixpkgs;
    in
    {
      packages = nixpkgs.legacyPackages.${system};
      overlays.default = selfPkgs.overlay;
      nixosConfigurations.hollow = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self user; };
        modules = [ ./hosts/hollow ];
      };
    };
}
