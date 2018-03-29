describe ("Hinemosエージェント確認") do
  installer = property[:HinemosAgent][:installer] rescue nil
  describe ("Hinemosエージェントがインストールされていること"), :if => installer != nil do
    package = property[:HinemosAgent][:installer]
    package.slice!(".rpm")
    describe package( package ) do
      it { should be_installed }
    end
  end

  manager_ip = property[:HinemosAgent][:hinemos_manager][:ip] rescue nil
  describe ("HinemosマネージャのIPアドレスが#{ manager_ip }であること"), :if => manager_ip != nil do
    describe file("/opt/hinemos_agent/conf/Agent.properties") do
      its(:content) { should match /^managerAddress=http:\/\/#{ manager_ip }:8081\/HinemosWS\// }
    end
  end

  service_HinemosAgent = property[:HinemosAgent][:service_HinemosAgent] rescue nil
  if service_HinemosAgent != nil
    describe service(property[:HinemosAgent][:service_HinemosAgent][:name]) do
      if property[:HinemosAgent][:service_HinemosAgent][:state] != nil
        context ("の状態が 実行中 であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:state] == 'started' do
          it { should be_running }
        end
        context ("の状態が 停止 であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:state] == 'stopped' do
          it { expect(should_not(be_running) && should(be_installed)).to eq(true) }
        end
      end

      describe ("のサービスの自動起動設定が #{ property[:HinemosAgent][:service_HinemosAgent][:enabled] } であること"), 
        :if => property[:HinemosAgent][:service_HinemosAgent][:enabled] != nil do
        if property[:HinemosAgent][:service_HinemosAgent][:enabled] == true 
          it { should be_enabled }
        else
          it { should_not be_enabled }
        end
      end
    end
  end

end
