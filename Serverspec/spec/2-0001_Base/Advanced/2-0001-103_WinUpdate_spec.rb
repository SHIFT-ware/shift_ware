describe ("103_WinUpdate") do

  begin
    windows_update = property[:ADVANCED][:windows_update]
  rescue
    windows_update = nil
  end

  describe ("Windows Update") do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update') do
      case windows_update
      when "autoinstall"
        context ("の設定が 更新プログラムを自動的にインストールする（推奨） であること") do
          it { should have_property_value('AUOptions', :type_dword, "4") }
        end
      when "downloadonly"
        context ("の設定が 更新プログラムをダウンロードするが、インストールを行うかどうかは選択する であること") do
          it { should have_property_value('AUOptions', :type_dword, "3") }
        end
      when "checkonly"
        context ("の設定が 更新プログラムを確認するが、ダウンロードとインストールを行うかどうかは選択する であること") do
          it { should have_property_value('AUOptions', :type_dword, "2") }
        end
      when "disabled"
        context ("の設定が 更新プログラムを確認しない（推奨されません） であること") do
          it { should have_property_value('AUOptions', :type_dword, "1") }
        end
      end
    end
  end
end
