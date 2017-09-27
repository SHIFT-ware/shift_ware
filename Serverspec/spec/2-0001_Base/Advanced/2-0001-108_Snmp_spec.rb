describe ("108_Snmp")do
  describe ("SNMP サービス") do
    describe ("の トラップ タブ") do

      begin
        trap_communities = Array(property[:ADVANCED][:snmp][:trap][:community])
      rescue
        trap_communities = []
      end
      trap_communities.each do |community|
        raise "テストに必要なパラメータADVANCED.snmp.trap.community.nameが不足しています" if community[:name] == nil
        describe ("において コミュニティ[#{ community[:name] }]") do
          describe command("Get-Item 'Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\SNMP\\Parameters\\TrapConfiguration\\#{ community[:name] }'") do
            begin
              dests = Array(community[:send_trap_to])
            rescue
              dests = []
            end

            dests.each do |dest|
              describe ("のトラップ送信先が #{ dest[:ip] } であること"), :if => dest[:ip] != nil do
                its(:stdout) { should match /\d\s+:\s+#{dest[:ip]}\s/ }
              end
            end
          end
        end
      end
    end

    describe ("の セキュリティ タブ") do
      begin
        security = property[:ADVANCED][:snmp][:security]
      rescue
        security = nil
      end

      next if security == nil

      describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters') do 
        context ("において 認証トラップを送信する が 有効 であること"), :if => security[:authentication_trap] == true do
          it { should have_property_value('EnableAuthenticationTraps', :type_dword, "1") }
        end
        context ("において 認証トラップを送信する が 無効 であること"), :if => security[:authentication_trap] == false do
          it { should have_property_value('EnableAuthenticationTraps', :type_dword, "0") }
        end
      end


      begin
        sec_communities = Array(property[:ADVANCED][:snmp][:allow_trap_from][:community])
      rescue
        sec_communities = []
      end

      describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities') do

        sec_communities.each do |community|

          describe ("において コミュニティ[#{ community[:name] }] からのSNMPパケットを受け付けること") do
            it { should have_property("#{community[:name]}", :type_dword) }
          end

          case community[:rights]
          when "none"
            context ("において コミュニティ[#{ community[:name] }] の権限が なし であること"), :if => community[:rights] == "none" do 
              it { should have_property_value("#{community[:name]}", :type_dword, "1") }
            end
          when "notify"
            context ("において コミュニティ[#{ community[:name] }] の権限が 通知 であること"), :if => community[:rights] == "notify" do
              it { should have_property_value("#{community[:name]}", :type_dword, "2") }
            end
          when "readonly"
            context ("において コミュニティ[#{ community[:name] }] の権限が 読み取りのみ であること"), :if => community[:rights] == "readonly" do
              it { should have_property_value("#{community[:name]}", :type_dword, "4") }
            end
          when "readwrite"
            context ("において コミュニティ[#{ community[:name] }] の権限が 読み取り、書き込み であること"), :if => community[:rights] == "readwrite" do
              it { should have_property_value("#{community[:name]}", :type_dword, "8") }
            end
          when "readcreate"
            context ("において コミュニティ[#{ community[:name] }] の権限が 読み取り、作成 であること"), :if => community[:rights] == "readcreate" do
              it { should have_property_value("#{community[:name]}", :type_dword, "16") }
            end
          end
        end
      end
    end

    begin
      hosts = Array(property[:ADVANCED][:snmp][:security][:allow_trap_from][:host])
    rescue
      hosts = []
    end

    describe command("Get-Item 'Registry::HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\\SNMP\\Parameters\\PermittedManagers'") do
      hosts.each do |host|
        describe ("において ホスト[#{ host[:ip] }] からのSNMPパケットを受け付けること"), :if => host[:ip] != nil do
          its(:stdout) { should match /\d\s+:\s+#{host[:ip]}\s/ }
        end
      end
    end
  end
end

