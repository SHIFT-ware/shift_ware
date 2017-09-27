describe ("109_Organization") do

  begin
    organization = property[:ADVANCED][:organization]
  rescue
    organization = nil
  end

  describe ("サーバの 組織名 が #{ organization } であること"), :if => organization != nil do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion') do
      it { should have_property_value('RegisteredOrganization', :type_string, "#{ organization }") }
    end
    
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion') do
      it { should have_property_value('RegisteredOrganization', :type_string, "#{ organization }") }
    end
  end
end

