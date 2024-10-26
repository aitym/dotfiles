{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    jetbrains.phpstorm
  ];
  virtualisation.docker.enable = true;
}
