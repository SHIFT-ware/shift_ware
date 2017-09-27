describe ("072-Interface") do
  begin
    interfaces = property[:NETWORK][:interface]
  rescue NoMethodError
    interfaces = nil
  end

  next if interfaces == nil

  interfaces.each do |interface|
    name = interface[:name]
    ip_addr = interface[:ip_addr]

    describe interface(name) do
      describe ("がupしていること") do
        it { should be_up }
      end

      describe ("のIPアドレスが#{ ip_addr }であること"), :if => ip_addr != nil do
        it { should have_ipv4_address(ip_addr) }
      end
    end
  end
end


describe ("072-BondingInterface") do
  begin
    bonding_interfaces = property[:NETWORK][:bonding_interface]
  rescue NoMethodError
    bonding_interfaces = nil
  end

  next if bonding_interfaces == nil

  bonding_interfaces.each do |bonding_interface|
    bonding_name = bonding_interface[:name]
    member_interfaces = bonding_interface[:member_interface]

    raise "テストに必要なパラメータNETWORK.bonding_interface.nameが不足しています" if name == nil

    describe bond("#{ bonding_name }") do
      describe ("が存在していること") do
        it { should exist }
      end

      next if member_interfaces == nil

      member_interfaces.each do |member_interface|
        member_name = member_interface[:name]

        describe ("のメンバーインターフェイスとして#{ member_name }がアサインされていること") do
          it { should have_interface member_name }
        end

        ifcfg_path = "/etc/sysconfig/network-scripts/ifcfg-#{ member_name }" if os[:release].include?("6.")
        ifcfg_path = "/etc/sysconfig/network-scripts/ifcfg-bond-slave-#{ member_name }" if os[:release].include?("7.")

        context file( ifcfg_path ) do
          describe ("#{ member_name } のマスターインターフェースが#{ bonding_name }であること") do
            its(:content) { should match /^MASTER=(\"#{ bonding_name }\"|#{ bonding_name })\s*$/ }
          end

          describe ("#{ member_name }がメンバーインターフェースとして設定されていること") do
            its(:content) { should match /^SLAVE=(\"yes\"|yes)\s*$/ }
          end
        end
      end
    end
  end
end
