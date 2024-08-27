{ lib, ... }:
{
  users.users.aitym = {
    isNormalUser = true;
    description = "Aitym";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialHashedPassword = "";
  };
  users.users.root.initialHashedPassword = "";
  security.sudo = {
    enable = lib.mkDefault true;
    wheelNeedsPassword = lib.mkImageMediaOverride false;
  };
  services.getty.autologinUser = "aitym";
}
