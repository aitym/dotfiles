{ pkgs, ... }:
let
  php83 = pkgs.php83.buildEnv {
    extensions = { enabled, all }: enabled ++ (with all; [ xdebug ]);
    extraConfig = ''
      short_open_tag=off
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    jetbrains.phpstorm
    php83
    php83Packages.composer
    (callPackage ./packages/symfony-cli.nix {})
  ];
}
