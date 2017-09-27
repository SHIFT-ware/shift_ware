describe ("021-SystemInfo") do
  begin
    os_name = property[:BASE][:OSCORE][:systeminfo][:os_name]
  rescue
    os_name = nil
  end

  next if os_name == nil

  describe ("OSのキャプション（OSバージョン・ライセンス）が#{ os_name }であること") do
    describe command("Write-Host -NoNewLine ((Get-WmiObject -Class Win32_OperatingSystem).Caption)") do
      its(:stdout) { should match /#{ os_name }/ }
    end
  end
end
