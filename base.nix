{ ... }:
{

  #powerManagement.cpuFreqGovernor = "ondemand";


  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 40d";
    dates = "weekly";
  };


  boot = {
    # Imporved networking
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
    kernel.sysctl."net.core.default_qdisc" = "fq";

    #kernel.sysctl = {
    #  "vm.swappiness" = 5;
    #  "fs.inotify.max_user_watches" = 524288;
    #};
    tmp.cleanOnBoot = true;
    tmp.useTmpfs = true;
  };

  services = {
    resolved = {
      enable = true;
      extraConfig = ''
        DNS=1.1.1.1 1.0.0.1
      '';
    };
    fwupd.enable = true;
    #dbus.packages = with pkgs; [ dconf ];
#    openssh.enable = true;
#    openssh.settings.PasswordAuthentication = false;
    #tlp.enable = true;
  };

  hardware = {
    #enableRedistributableFirmware = true;
    #enableAllFirmware = true;
    #opengl = {
    #  enable = lib.mkDefault true;
    #  driSupport32Bit = config.hardware.opengl.enable;
    #  #extraPackages = with pkgs; [
    #  #  rocm-opencl-icd
    #  #  rocm-opencl-runtime
    #  #  amdvlk
    #  #];
    #  #extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    #};
    cpu.intel.updateMicrocode = true;
  };
}
