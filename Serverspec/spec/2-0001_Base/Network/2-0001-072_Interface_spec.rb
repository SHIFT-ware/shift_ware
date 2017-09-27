
if property[:NETWORK] != nil then
  if property[:NETWORK][:eth] != nil then

    describe("072-Interface")do
      property[:NETWORK][:eth].each do |e|

        describe ("NIC[#{ e[:name] }]") do
    
          describe ("が存在すること") do
            describe command ("(Get-NetAdapter).InterfaceAlias") do
              if e[:name] != nil
                its(:stdout) { should match /(\A|\R)#{ e[:name] }(\R|\Z)/ }
              else
                it { fail "required parameter is not defined" }
              end
            end
          end
    
          describe ("のDHCP設定")do
            context ("が 無効(固定IP) であること"), :if => e[:dhcp] == FALSE do
              describe command ("Write-Host -NoNewline ((Get-NetIPInterface -InterfaceAlias '#{ e[:name] }' -AddressFamily IPv4).Dhcp) ") do
                its(:stdout) { should eq "Disabled" } 
              end
            end
            context ("が 有効 であること"), :if => e[:dhcp] == TRUE do
              describe command ("Write-Host -NoNewline ((Get-NetIPInterface -InterfaceAlias '#{ e[:name] }' -AddressFamily IPv4).Dhcp)") do
                its(:stdout) { should eq "Enabled" } 
              end
            end
          end
    
          describe ("のステータスが #{ e[:status] } であること"), :if => e[:status] != nil do
            describe command("Write-Host -NoNewline ((Get-NetAdapter -Name '#{ e[:name] }').Status)") do
              its(:stdout) { should eq "#{ e[:status] }" }
            end
          end
    
          describe ("のIPアドレスが #{ e[:ipaddress] } であること"), :if => e[:ipaddress] != nil do
            describe command ("Write-Host -NoNewline ((Get-NetIPAddress -InterfaceAlias '#{ e[:name] }' -AddressFamily IPv4).IPAddress)") do
              its(:stdout) { should eq "#{ e[:ipaddress] }" }
            end
          end
    
          describe ("のサブネットマスク長が #{ e[:prefix] }bit であること"), :if => e[:prefix] != nil do
            describe command ("Write-Host -NoNewline ((Get-NetIPAddress -InterfaceAlias '#{ e[:name] }' -AddressFamily IPv4).PrefixLength)") do
              its(:stdout) { should eq "#{ e[:prefix] }" }
            end
          end
    
    
          describe ("のNetBIOS設定") do
            describe command("Write-Host -NoNewLine ((Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.InterfaceIndex -eq $(Get-NetAdapter -Name '#{ e[:name] }').ifIndex}).TcpipNetbiosOptions)") do
              context ("が 既定値(DHCPからの設定を使用) であること"), :if => e[:netbios] == "dhcp" do
                its(:stdout) { should eq "0" }
              end
              context ("が 無効 であること"), :if => e[:netbios] == "disabled" do
                its(:stdout) { should eq "1" }
              end
              context ("が 有効 であること"), :if => e[:netbios] == "enabled" do
                its(:stdout) { should eq "2" }
              end
            end
          end

        end
      end
    end

  end
end
