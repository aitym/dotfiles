{ lib, ... }:
{
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "laptop";
  networking.extraHosts =
    ''
      127.0.0.1 app.mpa.local
    '';
  networking.networkmanager.enable = true;
}
