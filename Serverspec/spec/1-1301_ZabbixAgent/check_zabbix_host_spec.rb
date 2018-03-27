require 'open3'
require 'json'

describe ("Zabbix ホスト") do

  if property[:ZabbixAgent][:zabbix_host] != nil
    o, e, s = Open3.capture3("zabbix_gethost " + property[:ZabbixAgent][:zabbix_host][:server_url] + " " + property[:ZabbixAgent][:zabbix_host][:login_user] + " " + property[:ZabbixAgent][:zabbix_host][:login_pass] + " " + property[:ZabbixAgent][:zabbix_host][:host_name])
    rtnval = JSON.parse(o)
    # p rtnval

    describe ("ホスト名が #{ property[:ZabbixAgent][:zabbix_host][:host_name] } の Zabbix ホストが登録されていること") do
      it { expect( rtnval.has_key?("hostid") ).to eq true }
    end

    if rtnval.has_key?("hostid")
      describe ("登録された Zabbix ホストの表示名が #{ property[:ZabbixAgent][:zabbix_host][:visible_name] } であること"), :if => property[:ZabbixAgent][:zabbix_host][:visible_name] != nil do
        it { expect( rtnval["name"] ).to eq property[:ZabbixAgent][:zabbix_host][:visible_name] }
      end

      describe ("登録された Zabbix ホストのステータスが #{ property[:ZabbixAgent][:zabbix_host][:status] } であること"), :if => property[:ZabbixAgent][:zabbix_host][:status] != nil do
        status_val = '0'
        if property[:ZabbixAgent][:zabbix_host][:status] != 'enabled'
          status_val = '1'
        end
        it { expect( rtnval["status"] ).to eq status_val }
      end

      for spec_group in property[:ZabbixAgent][:zabbix_host][:host_groups]
        describe ("登録された Zabbix ホストのホストグループに #{ spec_group } が含まれること") do
          flag = false
          for rtn_group in rtnval["groups"]
            if spec_group == rtn_group["name"]
              flag = true
            end
          end
          it { expect( flag ).to eq true }
        end
      end

      for spec_template in property[:ZabbixAgent][:zabbix_host][:link_templates]
        describe ("登録された Zabbix ホストにテンプレート #{ spec_template } が割り当てられていること") do
          flag = false
          for rtn_template in rtnval["parentTemplates"]
            if spec_template == rtn_template["name"]
              flag = true
            end
          end
          it { expect( flag ).to eq true }
        end
      end
      
      for spec_if in property[:ZabbixAgent][:zabbix_host][:interfaces]
        flag = false
        for rtn_if in rtnval["interfaces"]
          if spec_if["useip"] == 1
            if spec_if["ip"] == rtn_if["ip"]
              flag = true
              break              
            end
          else
            if spec_if["dns"] == rtn_if["dns"]
              flag = true
              break
            end
          end
        end
        if spec_if["useip"] == 1
          # p "useip:1, flag: #{flag}"
          describe ("登録された Zabbix ホストにIPアドレス #{ spec_if["ip"] } のインターフェースが割り当てられていること") do
            it { expect( flag ).to eq true }
          end
        else
          # p "useip:0, flag: #{flag}"
          describe ("登録された Zabbix ホストにDNS名 #{ spec_if["dns"] } のインターフェースが割り当てられていること") do
            it { expect( flag ).to eq true }
          end
        end
      end

    end
  end

end
