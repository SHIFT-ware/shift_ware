describe ("024-Timezone") do

  begin
    time = property[:BASE][:OSCORE][:time]
  rescue NoMethodError
    time = nil
  end

  next if time == nil

  describe ("timezoneが#{ time[:timezone] }であること"), :if => time[:timezone] != nil do
    context file('/etc/sysconfig/clock') do
      its(:content) { should match /^ZONE="#{ time[:timezone] }"$/ } if os[:release].include?("6.")
    end

    context file('/etc/localtime') do
      it { should be_symlink } if os[:release].include?("7.")
      it { should be_linked_to "../usr/share/zoneinfo/#{ time[:timezone] }" } if os[:release].include?("7.")
    end
  end

  describe ("ハードウェアクロックのUTC設定が#{ time[:utc] }になっていること"), :if => time[:utc] != nil do
    hw_clock = "UTC" if time[:utc] == TRUE    
    hw_clock = "LOCAL" if time[:utc] == FALSE
    
    context file('/etc/adjtime') do
      its(:content) { should match /^#{ hw_clock }\s*$/ }
    end
  end
end
