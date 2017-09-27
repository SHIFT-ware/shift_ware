
if property[:NETWORK] != nil then
  if property[:NETWORK][:name_resolve] != nil then

    describe ("079-NameResolve") do

      n = property[:NETWORK][:name_resolve]

      describe file('C:\Windows\System32\Drivers\etc\hosts') do
        if n[:hosts_records] != nil
          n[:hosts_records].each do |h|
            describe ("hostsファイルに #{ h[:ip] } => #{ h[:hostname] } のエントリが存在すること"), :if => h[:hostname] != nil && h[:ip] != nil do
              its(:content) { should match /(\A|\R)#{ h[:ip] }(\s|\s.*\s)#{h[:hostname]}(\s|\R|\Z)/ }
            end
          end 
        end
      end

      if n[:dns_server] != nil
        if n[:dns_server][:nic_name] != nil
          n[:dns_server][:server].each do |d|
    
            if  n[:dns_server] != nil then
              describe ("DNSサーバとして #{ d[:ip] } が指定されていること") do
                context command("netsh interface ipv4 show dnsserver") do
                  its(:stdout) { should match /\s#{ d[:ip] }\s/ }
                end
              end
              describe ("DNSサーバとして NIC[#{ n[:dns_server][:nic_name] }] に #{ d[:ip] } が指定されていること") do
                context command("netsh interface ipv4 show dnsserver name='#{n[:dns_server][:nic_name]}'") do
                  its(:stdout) { should match /\s#{ d[:ip] }\s/ }
                end
              end
            end
    
          end
        else
          it { fail "required parameter is not defined"}
        end
      end

    end

  end
end
