describe ("2-1301_ZabbixAgent") do
  if property[:ZabbixAgent][:installer] != nil && property[:ZabbixAgent][:install_path] != nil
    describe ("#{ property[:ZabbixAgent][:installer] }が存在すること") do
      describe file("#{ property[:ZabbixAgent][:install_path] }\\#{ property[:ZabbixAgent][:installer] }") do
        it { should be_file }
      end
    end
  end

  if property[:ZabbixAgent][:files] != nil && property[:ZabbixAgent][:install_path] != nil
    property[:ZabbixAgent][:files].each do |file|
      describe ("#{ file[:name] }が存在すること") do
        describe file("#{ property[:ZabbixAgent][:install_path] }\\#{ file[:name] }") do
          it { should be_file }
        end
      end
    end
  end

  describe service("Zabbix Agent") do
    describe ("ZabbixAgentのサービスが存在すること") do
      it { should be_installed }
    end

    if property[:ZabbixAgent][:service] != nil
      describe ("ZabbixAgentのサービスが") do
        if property[:ZabbixAgent][:service][:state] != nil
          context ("起動していること"), :if => property[:ZabbixAgent][:service][:state] == "started" do
            it { should be_running }
          end
          context ("停止していること"), :if => property[:ZabbixAgent][:service][:state] == "stopped" do
            it { expect(should_not(be_running) && should(be_installed)).to eq(true) }
          end
        end
  
        if property[:ZabbixAgent][:service][:start_mode] != nil
          context ("自動起動すること"), :if => property[:ZabbixAgent][:service][:start_mode] == "auto" do
            it { should be_enabled }
          end
          context ("自動起動しないこと"), :if => property[:ZabbixAgent][:service][:start_mode] == "manual" do
            it { should_not be_enabled }
          end
        end
      end
    end
  end

  if property[:ZabbixAgent][:config] != nil && property[:ZabbixAgent][:service] != nil && property[:ZabbixAgent][:service][:state] != nil && property[:ZabbixAgent][:service][:state] == "started"
    describe port("#{ property[:ZabbixAgent][:config][:listenport] }"), :if => property[:ZabbixAgent][:config][:listenport] != nil do
      describe ("#{ property[:ZabbixAgent][:config][:listenport] }番ポートをLISTENしていること") do
        it { should be_listening }
      end
    end
  end

  if property[:ZabbixAgent][:config] != nil
    describe file("#{ property[:ZabbixAgent][:install_path] }\\zabbix_agentd.conf") do
      describe ("LogFile=#{ property[:ZabbixAgent][:config][:logfile] }が設定されていること"), :if => property[:ZabbixAgent][:config][:logfile] != nil do
        its(:content) { should match /^LogFile=#{ Regexp.escape(property[:ZabbixAgent][:config][:logfile]) }\s*$/ }
      end
  
      describe ("EnableRemoteCommands=#{ property[:ZabbixAgent][:config][:enableremotecommands] }が設定されていること"), :if => property[:ZabbixAgent][:config][:enableremotecommands] != nil do
        its(:content) { should match /^EnableRemoteCommands=#{ property[:ZabbixAgent][:config][:enableremotecommands] }\s*$/ }
      end
  
      describe ("Server=#{ property[:ZabbixAgent][:config][:server] }が設定されていること"), :if => property[:ZabbixAgent][:config][:server] != nil do
        its(:content) { should match /^Server=#{ Regexp.escape(property[:ZabbixAgent][:config][:server]) }\s*$/ }
      end
  
      describe ("ListenPort=#{ property[:ZabbixAgent][:config][:listenport] }が設定されていること"), :if => property[:ZabbixAgent][:config][:listenport] != nil do
        its(:content) { should match /^ListenPort=#{ property[:ZabbixAgent][:config][:listenport] }\s*$/ }
      end
  
      describe ("ServerActive=#{ property[:ZabbixAgent][:config][:serveractive] }が設定されていること"), :if => property[:ZabbixAgent][:config][:serveractive] != nil do
        its(:content) { should match /^ServerActive=#{ Regexp.escape(property[:ZabbixAgent][:config][:serveractive]) }\s*$/ }
      end
  
      describe ("HostnameItem=#{ property[:ZabbixAgent][:config][:hostnameitem] }が設定されていること"), :if => property[:ZabbixAgent][:config][:hostnameitem] != nil do
        its(:content) { should match /^HostnameItem=#{ Regexp.escape(property[:ZabbixAgent][:config][:hostnameitem]) }\s*$/ }
      end
  
      describe ("Timeout=#{ property[:ZabbixAgent][:config][:timeout] }が設定されていること"), :if => property[:ZabbixAgent][:config][:timeout] != nil do
        its(:content) { should match /^Timeout=#{ property[:ZabbixAgent][:config][:timeout] }\s*$/ }
      end
 
      if property[:ZabbixAgent][:config][:include] != nil
        property[:ZabbixAgent][:config][:include].each do |include| 
          describe ("Include=#{ Regexp.escape(include[:path]) }が設定されていること") do
            its(:content) { should match /^Include=#{ Regexp.escape(include[:path]) }\s*$/ }
          end
        end
      end
    end
  end
end


