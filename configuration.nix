# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./cli.nix
      ./base.nix
    ];


  programs.gnupg.agent = {
    enable = true;
    #     enableSSHSupport = true;
  };



  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Set the GNOME/KDE Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  nixpkgs.config.allowUnfree = true;
  # Add steam for Finn
  # programs.steam.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable Docker:

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    #enableNvidia = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bernokl = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "berno";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      openssl
      htop
      git
      emacs
      ripgrep
      coreutils
      fd
      tmux
      nix-top
      slack
      #emacsPackages.doom
      direnv
      barrier
      xfce.mousepad
      mdbook
      mdbook-d2
      obs-studio
      vlc
      discord
			xclip
      yubikey-personalization
      yubikey-personalization-gui
      yubikey-manager
      google-chrome
      enpass
    ];
  };

  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://cache.iog.io"
  ];

  nix.settings.max-jobs = 16;

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };


  # List packages installed in system profile. To search, run:
  # $ x.package = pkgs.nixVersions.nix_2_17;nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
  ];

	fonts = {
    enableDefaultPackages = true;
    packages = [ pkgs.nerdfonts ];
  };

	fonts.fonts = with pkgs; [ nerdfonts noto-fonts-emoji noto-fonts ];

  # Enable the 1Passsword GUI with myself as an authorized user for polkit
  programs._1password-gui = {
    enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
# services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.11"; # Did you read the comment?
  system.stateVersion = "24.11"; # Did you read the comment?

}
