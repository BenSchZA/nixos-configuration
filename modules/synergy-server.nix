{ config, ... }:
{
	services.synergy.server = {
		enable = true;
		autoStart = true;
		configFile = "/home/bscholtz/config/modules/synergy-server.conf";
	};
}
