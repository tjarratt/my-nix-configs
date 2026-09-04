{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/secrets.nix
    ../../modules/bonjour.nix

    ./pihole.nix
    ./isponsor-block.nix
    ./zram-swap.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking = {
    hostName = "cerberos";

    wireless = {
      enable = true;
      secretsFile = config.sops.secrets."wireless.env".path;
      networks = {
        "MaisonEnRose" = {
          pskRaw = "ext:home_psk";
        };
      };
    };
  };

  sops.secrets = {
    "wireless.env" = {
      owner = config.users.users.wpa_supplicant.name;
      group = config.users.users.wpa_supplicant.group;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "tjarratt"
  ];

  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.tjarratt = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # development
      git
      lsof
      tree
      vim

      # perf
      htop
      btop

      # networking
      dnsutils
      unixtools.ifconfig
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
