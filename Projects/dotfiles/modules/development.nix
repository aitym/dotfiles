{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
  virtualisation.docker.enable = true;
}
