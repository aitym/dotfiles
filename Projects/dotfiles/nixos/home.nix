{ pkgs, ... }:
{
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
}
