{ config, pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Aqtobe";
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
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.aitym = {
    isNormalUser = true;
    description = "Aitym";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  home-manager = {
    useGlobalPkgs = true;
    users.aitym = { pkgs, ... }: {
      home.packages = [ pkgs.atool pkgs.httpie ];
      programs.bash = {
        enable = true;
        bashrcExtra = ''
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
          alias config='/run/current-system/sw/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
          /run/current-system/sw/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config status.showUntrackedFiles no
          eval "$(ssh-agent -s)"
          ssh-add ~/.ssh/personal_key
        '';
      };
      home.stateVersion = "24.05";
    };
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    git
    ungoogled-chromium
    jetbrains.phpstorm
    php83
  ];
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
}
