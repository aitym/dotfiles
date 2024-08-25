{ pkgs, ... }:
let
  symfony-cli = pkgs.stdenv.mkDerivation rec {
    pname = "symfony-cli";
    version = "4.28.1";
    src = pkgs.fetchurl {
      url = "https://github.com/symfony/cli/releases/download/v${version}/symfony_linux_amd64";
      sha256 = "66c2daf21e3acbdda8d826a0484b02e59255401d54027cdbe2605406f77933a8";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/symfony
      chmod +x $out/bin/symfony
    '';
    meta = with pkgs.lib; {
      description = "Symfony CLI";
      homepage = "https://symfony.com/download";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };
  php83 = pkgs.php83.buildEnv {
    extensions = { enabled, all }: enabled ++ (with all; [ xdebug ]);
    extraConfig = ''
      short_open_tag=off
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    neovim
    git
    jetbrains.phpstorm
    php83
    php83Packages.composer
    symfony-cli
  ];
  virtualisation.docker.enable = true;
}
