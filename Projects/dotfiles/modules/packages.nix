{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    htop
    discord
    telegram-desktop
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    gnumake
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    dart
  ];
}
