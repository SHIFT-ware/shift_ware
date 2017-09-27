describe ("1-0108_Pgpool-II(conf)") do
  describe file("/etc/pgpool-II/pgpool.conf") do
    md5sum = property[:Pgpool][:config][:md5sum] rescue nil
    describe ("のMD5値が#{ md5sum }であること"), :if => md5sum != nil do
      its(:md5sum) { should eq md5sum }
    end
  end

  describe file("/etc/pgpool-II/pcp.conf") do
    pcp_users = Array(property[:Pgpool][:pcp_users]) rescue []
    pcp_users.each do |pcp_user|
      pcp_name = pcp_user[:name] rescue nil
      if pcp_name != nil
        describe ("中にpcpユーザ#{ pcp_name }のエントリがあること") do
          its(:content) { should match /^#{ pcp_name }:/ }
        end
      else
        raise "テストに必要なパラメータPgpool.pcp_users.x.nameが不足しています"
      end
    end
  end

  describe file("/etc/pgpool-II/pool_passwd") do
    pool_passwds = Array(property[:Pgpool][:pool_passwd]) rescue []
    pool_passwds.each do |pool_passwd|
      pool_name = pool_passwd[:name] rescue nil
      if pool_name != nil
        describe ("中にpostgresqlユーザ#{ pool_name }のエントリがあること") do
          its(:content) { should match /^#{ pool_name }:/ }
        end
      else
        raise "テストに必要なパラメータPgpool.pool_passwd.x.nameが不足しています"
      end
    end
  end

  describe file("/etc/pgpool-II/pool_hba.conf") do
    pool_hbas = Array(property[:Pgpool][:pool_hba]) rescue []
    pool_hbas.each do |pool_hba|
      type = pool_hba[:type] rescue nil
      database = pool_hba[:database] rescue nil
      user = pool_hba[:user] rescue nil
      method = pool_hba[:method] rescue nil
      address = pool_hba[:address] rescue nil

      if type != nil && database != nil && user != nil && method != nil
        case type
        when "local"
          describe ("エントリ\"local #{ database } #{ user } #{ method }\"があること") do
            its(:content) { should match /^local\s+#{ database }\s+#{ user }\s+#{ method }\s*(|$)/ }
          end
        else
          describe ("エントリ\"#{ type } #{ database } #{ user } #{ Regexp.escape(address) } #{ method }\"があること") do
            its(:content) { should match /^#{ type }\s+#{ database }\s+#{ user }\s+#{ Regexp.escape(address) }\s+#{ method }\s*(|$)/ }
          end
        end
      else
        raise "テストに必要なパラメータPgpool.pool_hba.x.{type,database,user,method}が不足しています"
      end
    end
  end
end

