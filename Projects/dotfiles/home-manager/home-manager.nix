{ pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.aitym = {
    home.packages = [ pkgs.atool pkgs.httpie ];
    home.stateVersion = "24.05";
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
  };
}
