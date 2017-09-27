describe ("098-Rdp") do
  describe ("リモートデスクトップ接続") do

    begin
      rdp = property[:ADVANCED][:rdp]
    rescue
      rdp = nil
    end

    describe command('Write-Host -NoNewLine ((Get-WmiObject win32_TerminalServiceSetting -Namespace root\cimv2\TerminalServices).AllowTSConnections)') do
      context ("が有効(許可されている)であること"), :if => rdp == "enabled" do
        its(:stdout) { should eq "1" }
      end
      context ("が無効(許可されていない)であること"), :if => rdp == "disabled" do
        its(:stdout) { should eq "0" }
      end
    end
  end
end
