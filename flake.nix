{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    ags.url = "github:aylur/ags";
    dotfiles = {
      url = "github:samiulbasirfahim/Dotfiles";
      flake = false;
    };
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit nixpkgs;
    in
    {
      packages = nixpkgs.legacyPackages.${system};
      nixosConfigurations.hollow = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [ ./hosts/hollow ];
      };
    };
}
