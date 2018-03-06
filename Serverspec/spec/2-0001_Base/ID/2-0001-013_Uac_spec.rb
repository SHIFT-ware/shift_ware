# test
describe ("013_Uac") do

  begin
    level = property[:BASE][:ID][:uac][:level]
  rescue
    level = nil
  end

  describe ("ユーザー アカウント制御 (UAC)") do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') do

      case level
      when "high"
        context ("の設定が 次の場合は常に通知する であること") do
          it { should have_property_value('EnableLUA', :type_dword, "1") }
          it { should have_property_value('PromptOnSecureDesktop', :type_dword, "1") }
          it { should have_property_value('ConsentPromptBehaviorAdmin', :type_dword, "2") }
        end
      when "middle"
        context ("の設定が 規定 - プログラムがコンピューターに変更を加えようとする場合のみ通知する であること") do
          it { should have_property_value('EnableLUA', :type_dword, "1") }
          it { should have_property_value('PromptOnSecureDesktop', :type_dword, "1") }
          it { should have_property_value('ConsentPromptBehaviorAdmin', :type_dword, "5") }
        end
      when "low"
        context ("の設定が プログラムがコンピューターに変更を加えようとする場合のみ通知する (デスクトップを暗転しない) であること") do
          it { should have_property_value('EnableLUA', :type_dword, "1") }
          it { should have_property_value('PromptOnSecureDesktop', :type_dword, "0") }
          it { should have_property_value('ConsentPromptBehaviorAdmin', :type_dword, "5") }
        end
      when "disabled"
        context ("の設定が 以下の場合でも通知しない(LUAは有効) であること") do
          it { should have_property_value('EnableLUA', :type_dword, "1") }
          it { should have_property_value('PromptOnSecureDesktop', :type_dword, "0") }
          it { should have_property_value('ConsentPromptBehaviorAdmin', :type_dword, "0") }
        end
      when "lua_disabled"
        context ("の設定が 以下の場合でも通知しない(LUAも無効) であること") do
          it { should have_property_value('EnableLUA', :type_dword, "0") }
          it { should have_property_value('PromptOnSecureDesktop', :type_dword, "0") }
          it { should have_property_value('ConsentPromptBehaviorAdmin', :type_dword, "0") }
        end
      end
    end
  end
end
