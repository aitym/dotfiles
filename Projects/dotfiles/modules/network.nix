{ lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
}
