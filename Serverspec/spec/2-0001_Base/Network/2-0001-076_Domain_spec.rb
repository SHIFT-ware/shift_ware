
if property[:NETWORK] != nil then
  if property[:NETWORK][:domain] != nil then

    describe ("076_Domain") do

      d = property[:NETWORK][:domain]

      describe command("Write-Host -NoNewline ((Get-WMIObject Win32_ComputerSystem).PartOfDomain)"), :if => d[:type] != nil do

        context ("ドメイン に参加していること"), :if => d[:type] == "domain" do
          its(:stdout) { should eq "True" }
        end

        context ("ワークグループ に参加していること"), :if => d[:type] == "workgroup" do
          its(:stdout) { should eq "False" }
        end

      end

      describe ("参加している ドメイン/ワークグループ の名前が #{ d[:name] } であること"), :if => d[:name] != nil do

        describe command("Write-Host -NoNewline ((Get-WMIObject Win32_ComputerSystem).Domain)") do
          its(:stdout) { should eq "#{ d[:name] }" }
        end

      end

    end

  end
end
