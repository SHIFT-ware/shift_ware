describe ("051_Directory") do
  begin
    directories = Array(property[:STORAGE][:directory])
  rescue
    directories = []
  end

  directories.each do |directory|
    describe ("フォルダ[#{ directory[:path] }]") do

      describe ("が 存在すること") do
        describe file("#{ directory[:path] }") do
          it { should be_directory }
        end
      end

      describe ("の所有者が #{directory[:owner]} であること"), :if => directory[:owner] != nil do
        describe command("Write-Host -NoNewLine ((Get-Acl '#{directory[:path]}').Owner)") do
          its(:stdout) { should match /(\A|\\)#{Regexp.escape(directory[:owner])}\Z/ }
        end
      end
    end
  end

  # セミコロン(;)区切りでディレクトリを結合
  files = ""
  directories.each do |directory|
    files += "#{Regexp.escape(directory[:path])};"
  end
  files.chop!

  # 処理時間短縮のため、ACL設定を一度で全て取得し、ローカルで比較する方式を採用
  describe command("foreach ($path in ('#{files}'.Split(';'))){ if (Test-Path $path){foreach ($acl in ((Get-Acl -Path $path).Access | Where-Object {$_.IsInherited -eq $False})){'PATH_'+$path+',USER_'+$acl.IdentityReference.Value+',RIGHTS_'+$acl.FileSystemRights+',TYPE_'+$acl.AccessControlType+',INHERIT_'+$acl.InheritanceFlags+',PROPAGATION_'+$acl.PropagationFlags+','}}}") do
    directories.each do |directory|
      acls = Array(directory[:acl])
      acls.each do |acl|
        describe ("フォルダ[#{ directory[:path] }]に対する ユーザ[#{ acl[:user] }] のACL設定") do

          escape_path = Regexp.escape(Regexp.escape(directory[:path]))
          escape_user = Regexp.escape(acl[:user])

          describe ("の権限設定が #{acl[:rights]} であること"), :if => acl[:rights] != nil do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*RIGHTS_#{acl[:rights]},/ }
          end

          describe ("の種別(許可/拒否)設定が [#{acl[:type]}] であること"), :if => acl[:type] != nil do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*TYPE_#{acl[:type]},/ }
          end

          next if acl[:inherit] == nil

          thisfolder = acl[:inherit].include?("thisfolder")
          subfolder = acl[:inherit].include?("subfolder")
          file = acl[:inherit].include?("file")

          describe ("の継承設定が このフォルダーのみ であること"), :if => (thisfolder) && (!subfolder) && (!file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_None,PROPAGATION_None,/ }
          end
          describe ("の継承設定が このフォルダー、サブフォルダーおよびファイル であること"), :if => (thisfolder) && (subfolder) && (file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ContainerInherit, ObjectInherit,PROPAGATION_None,/ }
          end
          describe ("の継承設定が このフォルダーとサブフォルダー であること"), :if => (thisfolder) && (subfolder) && (!file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ContainerInherit,PROPAGATION_None,/ }
          end
          describe ("の継承設定が このフォルダーとファイル であること"), :if => (thisfolder) && (!subfolder) && (file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ObjectInherit,PROPAGATION_None,/ }
          end
          describe ("の継承設定が サブフォルダーとファイルのみ であること"), :if => (!thisfolder) && (subfolder) && (file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ContainerInherit, ObjectInherit,PROPAGATION_InheritOnly,/ }
          end
          describe ("の継承設定が サブフォルダーのみ であること"), :if => (!thisfolder) && (subfolder) && (!file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ContainerInherit,PROPAGATION_InheritOnly,/ }
          end
          describe ("の継承設定が ファイルのみ であること"), :if => (!thisfolder) && (!subfolder) && (file) do
            its(:stdout) { should match /^PATH_#{escape_path},USER_(|\S+\\)#{escape_user},.*INHERIT_ObjectInherit,PROPAGATION_InheritOnly,/ }
          end
        end
      end
    end
  end
end
