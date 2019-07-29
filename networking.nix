{ config, ... }:

{
  networking.hostId = "0edeb994";
  networking.hostName = "nixos"; # Define your hostname.

  networking.wireless.enable =
  false; # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
    wifi.macAddress = "random";
  };
  networking.nameservers = [ "1.1.1.1" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 6079 ];
  #networking.firewall.allowedUDPPorts = [ 1194 ];
  networking.firewall.allowedTCPPorts = [
    1714
    1715
    1716
    1717
    1718
    1719
    1720
    1721
    1722
    1723
    1724
    1725
    1726
    1727
    1728
    1729
    1730
    1731
    1732
    1733
    1734
    1735
    1736
    1737
    1738
    1739
    1740
    1741
    1742
    1743
    1744
    1745
    1746
    1747
    1748
    1749
    1750
    1751
    1752
    1753
    1754
    1755
    1756
    1757
    1758
    1759
    1760
    1761
    1762
    1763
    1764
    6079
    57621
    8545
  ];
  networking.firewall.allowedUDPPorts = [
    1714
    1715
    1716
    1717
    1718
    1719
    1720
    1721
    1722
    1723
    1724
    1725
    1726
    1727
    1728
    1729
    1730
    1731
    1732
    1733
    1734
    1735
    1736
    1737
    1738
    1739
    1740
    1741
    1742
    1743
    1744
    1745
    1746
    1747
    1748
    1749
    1750
    1751
    1752
    1753
    1754
    1755
    1756
    1757
    1758
    1759
    1760
    1761
    1762
    1763
    1764
    1194
    50624
    50625
    8545
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
