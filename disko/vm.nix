{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "table";
          format = "msdos";
          partitions = {
            boot = {
              name = "boot";
              size = "1G";
              type = "EF02";
            };
            root = {
              name = "root";
              size = "100%";
              bootable = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
