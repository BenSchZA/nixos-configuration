{ config, pkgs, ... }:

{
  nix = {
    binaryCaches = [ 
      "https://cache.nixos.org/" 
      "https://dapp.cachix.org" 
      "https://nixcache.reflex-frp.org"
    ];
    binaryCachePublicKeys =
    [ 
      "dapp.cachix.org-1:9GJt9Ja8IQwR7YW/aF0QvCa6OmjGmsKoZIist0dG+Rs=" 
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
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
