if property[:NETWORK] != nil then
  if property[:NETWORK][:teaming] != nil then

    describe ("075-Teaming") do

      property[:NETWORK][:teaming].each do |t|

        describe ("チーム[#{ t[:name] }]") do
          if t[:name] != nil
            describe ("の チーミングモード が #{ t[:mode] } であること"), :if => t[:mode] != nil do
              describe command("Write-Host -NoNewLine ((Get-NetLbfoTeam -Name '#{ t[:name] }').TeamingMode)") do
                its(:stdout) { should eq "#{ t[:mode] }" }
              end
            end
  
            describe ("の 負荷分散モード が #{ t[:lb_mode] } であること"), :if => t[:lb_mode] != nil do
              describe command("Write-Host -NoNewLine ((Get-NetLbfoTeam -Name '#{t[:name]}').LoadBalancingAlgorithm)") do
                its(:stdout) { should eq "#{ t[:lb_mode] }" }
              end
            end
  
            t[:physical_member].each do |m|
      
              describe ("の所属の物理NIC[#{ m[:name] }]") do
                describe ("が存在すること") do
                  describe command("(Get-NetLbfoTeamMember -Team '#{ t[:name] }').Name") do
                    if m[:name] != nil
                      its(:stdout) { should match /(\A|\R)#{ m[:name] }(\R|\Z)/ }
                    else
                      it { fail "required parameter is not defined" }
                    end
                  end
                end
                describe ("の Active/Standby が #{ m[:mode] } であること"), :if => m[:mode] != nil do
                  describe command("Write-Host -NoNewLine (Get-NetLbfoTeamMember -Team '#{ t[:name] }' -Name '#{ m[:name] }').AdministrativeMode") do
                    its(:stdout) { should eq "#{ m[:mode] }" }
                  end
                end
              end
            end
  
            t[:logical_member].each do |m|
      
              describe ("の所属の論理NIC[#{ m[:name] }]") do
                describe ("が存在すること") do
                  describe command("(Get-NetLbfoTeamNic -Team '#{ t[:name] }').Name") do
                    if m[:name] != nil
                      its(:stdout) { should match /(\A|\R)#{ m[:name] }(\R|\Z)/ }
                    else
                      it { fail "required parameter is not defined" }
                    end
                  end
                end
                describe ("の VlanID が #{ m[:vlan_id] } であること"), :if => m[:vlan_id] != nil do
                  describe command("Write-Host -NoNewLine (Get-NetLbfoTeamNic -Team '#{ t[:name] }' -Name '#{ m[:name] }').VlanID") do
                    its(:stdout) { should eq "#{ m[:vlan_id] || '' }" }
                  end
                end
              end
            end
          else
            it { fail "required parameter is not defined"}
          end
        end
      end
    end

  end
end
