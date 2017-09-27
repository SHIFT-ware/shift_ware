

describe ("091-NameResolve") do

  begin
    hosts_records = Array(property[:ADVANCED][:name_resolve][:hosts_records])
  rescue NoMethodError
    hosts_records = []
  end


  hosts_records.each do |hosts_record|
    describe ("#{ hosts_record[:server] }がhostsで名前解決され#{ hosts_record[:ip] }を返すこと"), :if => hosts_record[:ip] != nil  do
      describe host("#{ hosts_record[:server] }") do
        its(:ipaddress) { should eq hosts_record[:ip] }
      end
    end
  end

  describe file('/etc/resolv.conf') do

    begin
      name_servers = Array(property[:ADVANCED][:name_resolve][:name_server])
    rescue NoMethodError
      name_servers = []
    end

   name_servers.each do |name_server|
      name_server[:server].split(",").each do |server|
        describe ("/etc/resolv.confにのnameserverに#{ server }が設定されていること") do
          its(:content) { should match /^nameserver[\s\t]+#{ Regexp.escape(server) }\s*$/ }
        end
      end
    end

   begin
     dns_suffixes = Array(property[:ADVANCED][:name_resolve][:dns_suffix])
   rescue NoMethodError
     dns_suffixes = []
   end

   dns_suffixes.each do |dns_suffix|
     dns_suffix[:suffix].split(",").each do |suffix|
       describe ("/etc/resolv.confのsearchに#{ suffix }が設定されていること") do
         its(:content) { should match /^search[\s\t]+.*#{ Regexp.escape(suffix) }.*\s*$/ }
       end
     end 
   end
  end

  begin
    pri_name_resolve = property[:ADVANCED][:name_resolve][:pri_name_resolve]
  rescue NoMethodError
    pri_name_resolve = nil
  end

  describe file('/etc/nsswitch.conf') do
    context ("名前解決の優先度が hosts > dns になっていること"), :if => pri_name_resolve == "files" do
      its(:content) { should match "^hosts:.+files.+dns" }
    end
    context ("名前解決の優先度が dns > hosts になっていること"), :if => pri_name_resolve == "dns" do
      its(:content) { should match "^hosts:.+dns+.files" }
    end
  end
end
