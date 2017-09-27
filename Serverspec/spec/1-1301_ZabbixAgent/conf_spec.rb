describe ("1-1301_ZabbixAgent(package and service)") do
  listenport = property[:ZabbixAgent][:config][:listenport] rescue nil
  describe port("#{ listenport }"), :if => listenport != nil do
    state = property[:ZabbixAgent][:service][:state] rescue nil
    next if state != "started"    

    describe ("#{ listenport }番ポートをLISTENしていること") do
      it { should be_listening }
    end
  end

  describe file('/etc/zabbix/zabbix_agentd.conf') do
    pidfile = property[:ZabbixAgent][:config][:pidfile] rescue nil
    describe ("PidFile=#{ pidfile }が設定されていること"), :if => pidfile != nil do
      its(:content) { should match /^PidFile=#{ Regexp.escape(pidfile) }\s*$/ }
    end

    logfile = property[:ZabbixAgent][:config][:logfile] rescue nil
    describe ("LogFile=#{ logfile }が設定されていること"), :if => logfile != nil do
      its(:content) { should match /^LogFile=#{ Regexp.escape(logfile) }\s*$/ }
    end

    enableremotecommands = property[:ZabbixAgent][:config][:enableremotecommands] rescue nil
    describe ("EnableRemoteCommands=#{ enableremotecommands }が設定されていること"), :if => enableremotecommands != nil do
      its(:content) { should match /^EnableRemoteCommands=#{ enableremotecommands }\s*$/ }
    end

    server = property[:ZabbixAgent][:config][:server] rescue nil
    describe ("Server=#{ server }が設定されていること"), :if => server != nil do
      its(:content) { should match /^Server=#{ Regexp.escape(server) }\s*$/ }
    end

    listenport = property[:ZabbixAgent][:config][:listenport] rescue nil
    describe ("ListenPort=#{ listenport }が設定されていること"), :if => listenport != nil do
      its(:content) { should match /^ListenPort=#{ listenport }\s*$/ }
    end

    serveractive = property[:ZabbixAgent][:config][:serveractive] rescue nil
    describe ("ServerActive=#{ serveractive }が設定されていること"), :if => serveractive != nil do
      its(:content) { should match /^ServerActive=#{ Regexp.escape(serveractive) }\s*$/ }
    end

    hostnameitem = property[:ZabbixAgent][:config][:hostnameitem] rescue nil
    describe ("HostnameItem=#{ hostnameitem }が設定されていること"), :if => hostnameitem != nil do
      its(:content) { should match /^HostnameItem=#{ Regexp.escape(hostnameitem) }\s*$/ }
    end

    timeout = property[:ZabbixAgent][:config][:timeout] rescue nil
    describe ("Timeout=#{ timeout }が設定されていること"), :if => timeout != nil do
      its(:content) { should match /^Timeout=#{ timeout }\s*$/ }
    end

    allowroot = property[:ZabbixAgent][:config][:allowroot] rescue nil
    describe ("AllowRoot=#{ allowroot }が設定されていること"), :if => allowroot != nil do
      its(:content) { should match /^AllowRoot=#{ allowroot }\s*$/ }
    end

    includes = Array(property[:ZabbixAgent][:config][:include]) rescue []
    includes.each do |include|
      path = include[:path] rescue nil
      describe ("Include=#{ Regexp.escape(path) }が設定されていること") do
        its(:content) { should match /^Include=#{ Regexp.escape(path) }\s*$/ }
      end
    end
  end
end
