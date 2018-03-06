# test
describe ("011-OSユーザ") do
  begin
    users = Array(property[:BASE][:ID][:user])
  rescue
    users = []
  end

  users.each do |user|
    describe ("ユーザ[#{ user[:name] }]") do
      describe user("#{ user[:name] }") do
        describe ("が存在すること") do
          it { should exist }
        end

        begin
          groups = user[:groups].split(",")
        rescue
          groups = []
        end

        groups.each do |group|
          describe ("が グループ[#{ group }] に所属すること") do
            it { should belong_to_group "#{group.strip}" }
          end
        end
      end

      describe command("Write-Host -NoNewline ((Get-WmiObject -ClassName Win32_UserAccount | Where-Object {$_.Name -eq '#{user[:name]}'}).Disabled)")do
        context ("の [アカウントを無効にする] がチェックされていること"), :if => user[:account_disabled] == true do 
          its(:stdout) { should eq "True" }
        end
        context ("の [アカウントを無効にする] がチェックされていないこと"), :if => user[:account_disabled] == false do
          its(:stdout) { should eq "False" }
        end
      end

      describe command("Write-Host -NoNewline ((Get-WmiObject -ClassName Win32_UserAccount | Where-Object {$_.Name -eq '#{user[:name]}'}).PasswordChangeable)")do
        context ("の [ユーザはパスワードを変更できない] がチェックされていること"), :if => user[:user_cannot_change_password] == true do
          its(:stdout) { should eq "False" }
        end
        context ("の [ユーザはパスワードを変更できない] がチェックされていないこと"), :if => user[:user_cannot_change_password] == false do
          its(:stdout) { should eq "True" }
        end
      end

      describe command("Write-Host -NoNewline ((Get-WmiObject -ClassName Win32_UserAccount | Where-Object {$_.Name -eq '#{user[:name]}'}).PasswordExpires)")do
        context ("の [パスワードを無期限にする] がチェックされていること"), :if => user[:password_never_expires] == true do
          its(:stdout) { should eq "False" }
        end
        context ("の [パスワードを無期限にする] がチェックされていないこと"), :if => user[:password_never_expires] == false do
          its(:stdout) { should eq "True" }
        end
      end
    end
  end
end
