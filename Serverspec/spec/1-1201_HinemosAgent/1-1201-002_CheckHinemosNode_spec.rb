require 'open3'
require 'json'

hinemos_host = property[:HinemosAgent][:hinemos_node] rescue nil

if hinemos_host.nil? == false
  describe ("Hinemosノード確認") do
    if property[:HinemosAgent][:hinemos_node] != nil
      o, e, s = Open3.capture3("hinemos_getnode \"#{property[:HinemosAgent][:hinemos_manager][:ip]}\" \"#{property[:HinemosAgent][:hinemos_manager][:login_user]}\" \"#{property[:HinemosAgent][:hinemos_manager][:login_pass]}\" \"#{property[:HinemosAgent][:hinemos_node][:facility_id]}\"")
      rtnval = JSON.parse(o)

      describe ("ファシリティIDが #{ property[:HinemosAgent][:hinemos_node][:facility_id] } のHinemosノードが登録されていること") do
        it { expect( rtnval.has_key?("facilityId") ).to eq true }
      end

      if rtnval.has_key?("facilityId")
        describe ("登録されたHinemosノードのファシリティ名が #{ property[:HinemosAgent][:hinemos_node][:facility_name] } であること"), :if => property[:HinemosAgent][:hinemos_node][:facility_name] != nil do
          it { expect( rtnval["facilityName"] ).to eq property[:HinemosAgent][:hinemos_node][:facility_name] }
        end

        describe ("登録されたHinemosノードのIPv4アドレスが #{ property[:HinemosAgent][:hinemos_node][:ip] } であること"), :if => property[:HinemosAgent][:hinemos_node][:ip] != nil do
          it { expect( rtnval["ipAddressV4"] ).to eq property[:HinemosAgent][:hinemos_node][:ip] }
        end

        describe ("登録されたHinemosノードのオーナーロールIDが #{ property[:HinemosAgent][:hinemos_node][:role] } であること"), :if => property[:HinemosAgent][:hinemos_node][:role] != nil do
          it { expect( rtnval["ownerRoleId"] ).to eq property[:HinemosAgent][:hinemos_node][:role] }
        end

        if property[:HinemosAgent][:hinemos_node][:scope_id] != nil
          o2, e2, s2 = Open3.capture3("hinemos_getscope \"#{property[:HinemosAgent][:hinemos_manager][:ip]}\" \"#{property[:HinemosAgent][:hinemos_manager][:login_user]}\" \"#{property[:HinemosAgent][:hinemos_manager][:login_pass]}\" \"#{property[:HinemosAgent][:hinemos_node][:scope_id]}\"")
          rtnval2 = JSON.parse(o2)
    
          describe ("登録されたHinemosノードにスコープ #{ property[:HinemosAgent][:hinemos_node][:scope_id] } が割り当てられていること") do
            it { expect( rtnval2["facilityIdList"] ).to include property[:HinemosAgent][:hinemos_node][:facility_id] }
          end
        end    
      end
    end
  end
end