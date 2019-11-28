{config, pkgs, ...}:

{
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${config.services.xserver.displayManager.session.script} plasma5+none";
}
