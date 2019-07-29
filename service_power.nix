{ config, ... }:

{
  # This enables desktop power management, like the battery indicator
  services.upower.enable = true;
  services.tlp.enable = false;
}
