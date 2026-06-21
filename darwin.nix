{ pkgs, ... }:

{
  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  # pihole ahoy hoy
  networking = {
    knownNetworkServices = [ "Wi-fi" "Thunderbolt Bridge" ];

    dns = [
      "192.168.0.33"  # pihole wired
      "192.168.0.43"  # pihole wireless
      "192 168.0.254" # router
    ];
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;

      InitialKeyRepeat = 15;
      Keyrepeat = 2;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
    };

    CustomUserPreferences = {
      # disable siri
      "com.apple.Siri" = {
        "UAProfileCheckingStatus" = 0;
        "siriEnabled" = 0;
      };

      # disable personalized ads
      "com.apple.AdLib" = {
        allowAPplePersonalizedAdvertising = false;
      };
    };

    controlcenter.Sound = true;
    controlcenter.BatteryShowPercentage = true;
    controlcenter.FocusModes = false;

    dock = {
      autohide = true;
      autohide-delay = 0.33;
      dashboard-in-overlay = true;
      slow-motion-allowed = true;
    };

    finder.FXPreferredViewStyle = "Nlsv"; # list view
    finder.ShowPathbar = true;

    trackpad.Clicking = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.startup.chime = true;

  # death to hot corners
  system.defaults.dock = {
    wvous-br-corner = 1; # disabled
    wvous-bl-corner = 1; # disabled
    wvous-tl-corner = 1; # disabled
    wvous-tr-corner = 1; # disabled
  };
}

