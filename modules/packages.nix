{ config, pkgs, ... }:

{
  nix = {
    binaryCaches = [ "https://cache.nixos.org/" "https://dapp.cachix.org" ];
    binaryCachePublicKeys =
    [ "dapp.cachix.org-1:9GJt9Ja8IQwR7YW/aF0QvCa6OmjGmsKoZIist0dG+Rs=" ];
    trustedUsers = [ "root" "bscholtz" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = false;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        alsaSupport = true;
        pulseSupport = true;
      };
    };
  };

  nixpkgs.config.firefox.enableAdobeFlash = false;
}
