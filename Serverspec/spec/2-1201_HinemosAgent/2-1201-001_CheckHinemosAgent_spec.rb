describe ("Hinemosエージェント確認") do
  community_name = property[:HinemosAgent][:community][:name] rescue nil
  describe ("SNMPコミュニティ名が #{ community_name } であること"), :if => community_name != nil do 
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities') do
      it { should have_property("#{ community_name }", :type_dword) } 
    end
  end

  manager_ip = property[:HinemosAgent][:hinemos_manager][:ip] rescue nil
  describe ("SNMPパケットの受け付けホストが「読み取り」かつ #{ manager_ip } であること"), :if => manager_ip != nil do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers') do
      it { should have_property_value('2', :type_string, "#{ manager_ip }") } 
    end
  end

  agent_ver = property[:HinemosAgent][:version] rescue nil
  describe ("Hinemosエージェントのバージョンが#{ agent_ver }であること"), :if => agent_ver != nil do
    describe command("Write-Host -NoNewline (Get-WmiObject Win32_Product -filter \"Name Like '%HinemosAgent%'\").Version") do
      its(:stdout) { should eq "#{ agent_ver }" }
    end
  end

  install_path = property[:HinemosAgent][:install_path] rescue nil
  describe ("Hinemosエージェントのインストール先が#{ install_path }であること"), :if => install_path != nil do
    describe file("#{ install_path }\\bin") do
      it { should exist }
    end
  end

  describe ("HinemosマネージャのIPアドレスが#{ manager_ip }であること"), :if => manager_ip != nil do
    if install_path != nil
      describe file("#{ property[:HinemosAgent][:install_path] }\\conf\\Agent.properties") do
        its(:content) { should match /^managerAddress=http:\/\/#{ Regexp.escape( manager_ip ) }:8081\/HinemosWS\/\s$/ }
      end
    else
      describe ("テストに必要なパラメータ[:HinemosAgent][:install_path]が不足しています") do
        it { should raise_exception, "install path is undefiend" }
      end
    end
  end

  service_HinemosAgent = property[:HinemosAgent][:service_HinemosAgent] rescue nil
  if service_HinemosAgent != nil
    describe service(property[:HinemosAgent][:service_HinemosAgent][:name]) do

      describe ("が存在すること") do
        it { should be_installed }

        if property[:HinemosAgent][:service_HinemosAgent][:state] != nil
          context ("の状態が 実行中 であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:state] == 'started' do
            it { should be_running }
          end

          context ("の状態が 停止 であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:state] == 'stopped' do
            it { expect(should_not(be_running) && should(be_installed)).to eq(true) }
          end
        end

        describe ("のスタートアップの種類が #{ property[:HinemosAgent][:service_HinemosAgent][:start_mode] } であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:start_mode] != nil do
          it { should have_start_mode("#{ property[:HinemosAgent][:service_HinemosAgent][:start_mode] }") }
        end

        describe ("のログオンユーザが #{ property[:HinemosAgent][:service_HinemosAgent][:logon_account] } であること"), :if => property[:HinemosAgent][:service_HinemosAgent][:logon_account] != nil do
          describe command("gwmi win32_service | select name,startname | Where-Object {$_.name -eq '#{ property[:HinemosAgent][:service_HinemosAgent][:name] }'}") do
            its(:stdout) { should match /\s*#{ property[:HinemosAgent][:service_HinemosAgent][:logon_account] }\s*$/ }
          end
        end

      end

    end
  end

  service_snmp = property[:HinemosAgent][:service_SNMP] rescue nil
  if service_snmp != nil
    describe service("SNMP") do

      describe ("が存在すること ") do
        it { should be_installed }

        if property[:HinemosAgent][:service_SNMP][:state] != nil
          context ("の状態が 実行中 であること"), :if => property[:HinemosAgent][:service_SNMP][:state] == 'started' do
            it { should be_running }
          end

          context ("の状態が 停止 であること"), :if => property[:HinemosAgent][:service_SNMP][:state] == 'stopped' do
            it { expect(should_not(be_running) && should(be_installed)).to eq(true) }
          end
        end

        describe ("のスタートアップの種類が #{ property[:HinemosAgent][:service_SNMP][:start_mode] } であること"), :if => property[:HinemosAgent][:service_SNMP][:start_mode] != nil do
          it { should have_start_mode("#{ property[:HinemosAgent][:service_SNMP][:start_mode] }") }
        end

        describe ("のログオンユーザが #{ property[:HinemosAgent][:service_SNMP][:logon_account] } であること"), :if => property[:HinemosAgent][:service_SNMP][:logon_account] != nil do
          describe command("gwmi win32_service | select name,startname | Where-Object {$_.name -eq 'SNMP'}") do
            its(:stdout) { should match /\s*#{ property[:HinemosAgent][:service_SNMP][:logon_account] }\s*$/ }
          end
        end

      end

    end
  end

end
