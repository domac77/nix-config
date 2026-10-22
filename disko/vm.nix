{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/vda";
    content = {
      type = "table";
      format = "msdos";
      partitions = {
        boot = {
          type = "partition";
          start = "1M";
          end = "512M";
          bootable = true;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/boot";
          };
        };
        root = {
          type = "partition";
          start = "512M";
          end = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
