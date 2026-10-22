{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/vda";
    content = {
      type = "table";
      format = "msdos";
      partitions = [
        {
          name = "boot";
          start = "1M";
          end = "512M";
          bootable = true;
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/boot";
          };
        }
        {
          name = "root";
          start = "512M";
          end = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        }
      ];
    };
  };
}
