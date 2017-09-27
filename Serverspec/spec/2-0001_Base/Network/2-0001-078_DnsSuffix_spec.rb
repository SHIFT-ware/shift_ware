
if property[:NETWORK] != nil then
  if property[:NETWORK][:dns_suffix] != nil then

    describe ("078_DnsSuffix")do

      d = property[:NETWORK][:dns_suffix]

      describe ("DNSサフィックス") do

        if d[:primary] != nil then
          describe ("において このコンピュータのプライマリDNSサフィックス が #{ d[:primary][:fqdn] } であること"), :if => d[:primary][:fqdn] != nil do
            describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters') do
              it { should have_property_value('NV Domain', :type_string, "#{ d[:primary][:fqdn] }") }
            end
          end
      
          describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters') do
      
            context ("において ドメインのメンバーシップが変更されるときにプライマリDNSサフィックスを変更する が 有効 であること"), :if => d[:primary][:change_when_domain_membership_changed] == true do
              it { should have_property_value('SyncDomainWithMembership', :type_dword, "1") }
            end
      
            context ("において ドメインのメンバーシップが変更されるときにプライマリDNSサフィックスを変更する が 無効 であること"), :if => d[:primary][:change_when_domain_membership_changed] == false do
              it { should have_property_value('SyncDomainWithMembership', :type_dword, "0") }
            end
      
          end
        end

        if d[:all] !=nil then
          d[:all].each do |a|

            describe ("において DNSサフィックス が #{ a[:fqdn] } であること"), :if => a[:fqdn] != nil do
              describe command("(Get-DnsClientGlobalSetting).SuffixSearchList")do
                its(:stdout) { should match /(\A|\R)#{a[:fqdn]}(\R|\Z)/ }
              end
            end

          end
        end

      end
    end

  end
end
