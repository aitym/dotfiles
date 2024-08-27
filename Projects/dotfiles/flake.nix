{
  description = "My flake config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system;
        };
        modules = [
          ./modules/bootloader.nix
          ./modules/filesystem.nix
          ./modules/cpu.nix
          ./modules/not-detected.nix
          ./modules/locale.nix
          ./modules/time.nix
          ./modules/network.nix
          ./modules/bluetooth.nix
          ./modules/system.nix
          ./modules/user.nix
	      ./modules/xserver.nix
	      ./modules/sound.nix
	      ./modules/packages.nix
	      ./modules/development.nix
          inputs.nixvim.nixosModules.nixvim
          ./home-manager/home-manager.nix
        ];
      };
    };
}
