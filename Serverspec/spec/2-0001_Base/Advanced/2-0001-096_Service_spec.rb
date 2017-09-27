describe("096_Service")do

  begin
    services = Array(property[:ADVANCED][:service])
  rescue
    services = []
  end

  services.each do |service|
    describe service("#{service[:name]}") do
      describe ("が存在すること")do
        it { should be_installed }
      end

      context ("の状態が 実行中 であること"), :if => service[:state] == TRUE do
        it { should be_running }
      end
      context ("の状態が 停止 であること"), :if => service[:state] == FALSE do
        it { should_not be_running }
      end

      describe ("のスタートアップの種類が #{ service[:start_mode] } であること"), :if => service[:start_mode] != nil do
        it { should have_start_mode("#{service[:start_mode]}") }
      end
    end

    describe ("#{service[:name]}") do
      describe command ("Write-Host -NoNewline ((Get-ItemProperty HKLM:\\SYSTEM\\CurrentControlSet\\services\\$((Get-Service -DisplayName '#{service[:name]}').Name)).DelayedAutostart)") do
        context ("のスタートアップの種類が (遅延開始) であること"), :if => service[:delay_flag] == TRUE do
          its(:stdout) { should eq "1" }
        end
        context ("のスタートアップの種類が (遅延開始) でないこと"), :if => service[:delay_flag] == FALSE do
          its(:stdout) { should_not eq "1" }
        end
      end

      describe command("Write-Host -NoNewline (Test-Path HKLM:\\SYSTEM\\CurrentControlSet\\services\\$((Get-Service -DisplayName '#{service[:name]}').Name)\\TriggerInfo)") do
        context ("のスタートアップの種類が (トリガー開始) であること"), :if => service[:trigger_flag] == TRUE do
          its(:stdout) { should eq 'True' }
        end
        context ("のスタートアップの種類が (トリガー開始) でないこと"), :if => service[:trigger_flag] == FALSE do
          its(:stdout) { should eq 'False' }
        end
      end
    end
  end
end
