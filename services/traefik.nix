{ config, pkgs, ... }:

{
  services.traefik = {
    enable = true;
    group = "docker";
    configFile = "/var/lib/traefik/traefik.toml";
    package = pkgs.callPackage ./traefik-bin.nix {};
  };
}
