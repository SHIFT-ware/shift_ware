describe ("104_Owner") do

  begin
    owner = property[:ADVANCED][:owner]
  rescue
    owner = nil
  end

  describe ("サーバの 使用者名 が #{ owner } であること"), :if => owner != nil do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion') do
      it { should have_property_value('RegisteredOwner', :type_string, "#{ owner }") }
    end

    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion') do
      it { should have_property_value('RegisteredOwner', :type_string, "#{ owner }") }
    end
  end
end
