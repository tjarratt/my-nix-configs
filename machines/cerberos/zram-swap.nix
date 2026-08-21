# Raspberry Pi 3B still has a tremendous dearth of RAM
# running a naive 'nixos-rebuild switch' CAN AND WILL
# use all of the available RAM and result in failed builds.

# set this up once manually before the first nixos-rebuild
# and then benefit from having this setup forever afterwards

{
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
}
