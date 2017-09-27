describe ("027-Kdump") do

  begin
    kdump = property[:BASE][:OSCORE][:kdump]
  rescue NoMethodError
    kdump = nil
  end

  next if kdump == nil

  describe ("kdumpサービスのステータスが#{kdump[:service_state]}であること") , :if => kdump[:service_state] != nil do
    if kdump[:service_state] == "running"
      context service('kdump') do
        it { should be_running }
      end
    end

    if kdump[:service_state] == "stop"
      context service('kdump') do
        it { should_not be_running }
      end
    end
  end

  describe file('/etc/kdump.conf') do
    describe ("dump出力先のパスが#{kdump[:path]}であること"), :if => kdump[:path] != nil do
      its(:content) { should match "^path\s+#{kdump[:path]}\s*$" }
    end
  end 
end
