
if property[:NETWORK] != nil then
  if property[:NETWORK][:ipv6] != nil then

    describe ("077_IPv6Disable")do

      i = property[:NETWORK][:ipv6]

      describe ("IPv6設定") do

        describe ("が レジストリ から無効化されていること"), :if => i[:registry] == "disabled" do
          describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters') do
            it { should have_property_value('DisabledComponents', :type_dword, "0x000000ff") }
          end
        end

        describe ("が NICのプロパティ から 全NIC に対して無効化されていること"), :if => i[:nic_property] == "disabled" do
          describe command("foreach ($line in (Get-NetAdapter).InterfaceDescription){#{i[:nvspbind_path]} $line}") do
            its(:stdout) { should match /disabled:\s+ms_tcpip6\s/ }
            its(:stdout) { should_not match /(enabled|default):\s+ms_tcpip6\s/ }
          end
        end

        describe command ("netsh interface ipv6 show interface") do

          context ("が netshコマンド から ISATAP インタフェース に対して無効化されていること"), :if => i[:netsh_command][:isatap_if] == "disabled" do
            its(:stdout) { should_not match /isatap/ }
          end

          context ("が netshコマンド から 6to4 インタフェース に対して無効化されていること"), :if => i[:netsh_command][:sixtofour_if] == "disabled" do
            its(:stdout) { should_not match /6TO4/ }
          end

          context ("が netshコマンド から Teredo インタフェース に対して無効化されていること"), :if => i[:netsh_command][:teredo_if] == "disabled" do
            its(:stdout) { should_not match /Teredo/ }
          end

        end

      end

    end

  end
end
