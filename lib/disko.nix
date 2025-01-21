{
  device ? throw "Set this to your disk device (e.g. /dev/nvme0n1)",
  swapSize ? throw "Set this to the amount of RAM you have (e.g. 16G)",
  ...
}:
{
  disko.devices = {
    disk = {
      vdb = {
        device = device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = swapSize;
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=12G" "mode=755" ];
      };
    };
  };
}
