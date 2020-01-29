{ config, ... }:
{
	services.synergy.client = {
		enable = true;
		autoStart = true;
		serverAddress = "localhost:24800";
	};
}
