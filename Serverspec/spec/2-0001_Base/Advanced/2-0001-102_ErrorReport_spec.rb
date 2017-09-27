describe ("102_ErrorReport")do
  begin
    error_report = property[:ADVANCED][:error_report]
  rescue
    error_report = nil
  end

  next if error_report == nil

  describe ("Windows エラー報告") do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting') do
      context ("の設定が 有効 であること"), :if => error_report == "enabled" do
        it { should_not have_property_value('Disabled', :type_dword, "1") }
      end
      context ("の設定が 無効 であること"), :if => error_report == "disabled" do
        it { should have_property_value('Disabled', :type_dword, "1") }
      end
    end
  end
end
