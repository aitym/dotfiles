{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Aqtobe";
  services.printing.enable = true;
  security.rtkit.enable = true;
  users.users.aitym = {
    isNormalUser = true;
    description = "Aitym";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    git
    ungoogled-chromium
    htop
  ];
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
}
