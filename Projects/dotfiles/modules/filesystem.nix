{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44c3685b-750c-4a0a-8a33-d3efcf4c90ff";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2B79-9416";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };
  swapDevices = [];
}
