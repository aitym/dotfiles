{
  description = "My flake config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
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
          ./configuration.nix
          inputs.nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager = {
              users.aitym = { pkgs, ... }: {
                home.packages = [ pkgs.atool pkgs.httpie ];
                programs.bash = {
                  enable = true;
                  bashrcExtra = ''
                    . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
                    alias config='/run/current-system/sw/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
                    /run/current-system/sw/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config status.showUntrackedFiles no
                    eval "$(ssh-agent -s)"
                    ssh-add ~/.ssh/personal_key
                  '';
                };
                home.stateVersion = "24.05";
              };
            };
          }
        ];
      };
    };
}
