{pkgs, ...}:

{
    systemd.services.phoenix-blog = {
        enable = true;
        wantedBy = [ "multi-user.target" ]; 
        after = [ "network.target" ];
        description = "Start Phoenix/Elixir application";
        environment = {
            MIX_ENV = "prod";
            LANG = "en_US.UTF-8";
            PORT = "4002";
        };
        serviceConfig = {
            Type = "simple";
            User = "bscholtz";
            Restart = "on-failure";
            RestartSec = "5";
            StartLimitBurst = "3";
            StartLimitInterval = "10";
            WorkingDirectory = "/home/bscholtz/workspace-sync/phoenix-blog";
            ExecStart = ''/home/bscholtz/workspace-sync/phoenix-blog/_build/prod/rel/app/bin/app start'';
            ExecReload = ''/home/bscholtz/workspace-sync/phoenix-blog/_build/prod/rel/app/bin/app restart'';
            ExecStop = ''/home/bscholtz/workspace-sync/phoenix-blog/_build/prod/rel/app/bin/app stop'';
            EnvironmentFile = ''/home/bscholtz/workspace-sync/phoenix-blog/.envrc'';
        };
    };
}
