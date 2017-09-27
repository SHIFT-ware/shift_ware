describe ("026-Selinux") do
  begin
    selinux_status = property[:BASE][:OSCORE][:selinux]
  rescue NoMethodError
    selinux_status = nil
  end

  describe ("SElinuxが#{selinux_status}であること"), :if => selinux_status != nil do

    matcher = "be_#{selinux_status}"

    describe selinux do
      it { should eval "#{matcher}"}
    end
  end
end 
