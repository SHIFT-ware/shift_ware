describe ("1-1301_ZabbixAgent(package and service)") do
  describe ("ZabbixAgentがインストールされていること") do
    describe package("zabbix-agent") do
      it { should be_installed }
    end
  end

  describe service("zabbix-agent") do
    describe ("ZabbixAgentのサービスが") do
      state = property[:ZabbixAgent][:service][:state] rescue nil
      context ("起動していること"), :if => state == "started" do
        it { should be_running }
      end
      context ("停止していること"), :if => state == "stopped" do
        it { should_not be_running }
      end

      enabled = property[:ZabbixAgent][:service][:enabled] rescue nil
      context ("自動起動すること"), :if => enabled == "yes" do
        it { should be_enabled }
      end
      context ("自動起動しないこと"), :if => enabled == "no" do
        it { should_not be_enabled }
      end
    end
  end
end
