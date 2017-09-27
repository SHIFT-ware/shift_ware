
if property[:NETWORK] != nil then
  if property[:NETWORK][:firewall] != nil then

    describe("074_Firewall")do
      f = property[:NETWORK][:firewall]
      
      describe ("Windows ファイアウォール設定") do

        if  f[:domain] != nil then
          describe ("の ドメイン プロファイル") do
            describe ("の有効化フラグ=#{ f[:domain][:enabled_flag] }であること"), :if => f[:domain][:enabled_flag] != nil do
              describe command('Write-Host -NoNewLine ((Get-NetFirewallProfile -Name Domain).Enabled)') do
                its(:stdout) { should eq "#{ f[:domain][:enabled_flag] }" }
              end
            end
          end
        end
        if  f[:private] != nil then
          describe ("の プライベート プロファイル"), :if => f[:private] != nil do
            describe ("の有効化フラグ=#{ f[:private][:enabled_flag] }であること"), :if => f[:private][:enabled_flag] != nil do
              describe command('Write-Host -NoNewLine ((Get-NetFirewallProfile -Name Private).Enabled)') do
                its(:stdout) { should eq "#{ f[:private][:enabled_flag] }" }
              end
            end
          end
        end
        if  f[:public] != nil then
          describe ("の パブリック プロファイル"), :if => f[:public] != nil do
            describe ("の有効化フラグ=#{ f[:public][:enabled_flag] }であること"), :if => f[:public][:enabled_flag] != nil do
              describe command('Write-Host -NoNewLine ((Get-NetFirewallProfile -Name Public).Enabled)') do
                its(:stdout) { should eq "#{ f[:public][:enabled_flag] }" }
              end
            end
          end
        end
      end
    end

  end
end
