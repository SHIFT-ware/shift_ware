describe ("postgreSQL(Authentication)") do
  version = property[:PostgreSQL][:version] rescue nil
  if version != nil
    describe file("/var/lib/pgsql/#{ property[:PostgreSQL][:version] }/data/pg_hba.conf") do
      records = Array(property[:PostgreSQL][:authentication][:records]) rescue []
      records.each do |auth_record|
        database = auth_record[:database] rescue nil
        user = auth_record[:user] rescue nil
        address = auth_record[:address] rescue nil
        method = auth_record[:method] rescue nil
        type = auth_record[:type] rescue nil

        describe ("に「#{ type } #{ database } #{ user } #{ address } #{ method }」のレコードが記載されていること") do
          case type
          when nil
            raise "pg_hba.confの確認にはパラメータPostgreSQL.authentication.records.x.typeが必要です"
          when "local"
            if database != nil && user != nil && method != nil
              its(:content) { should match /^local \s*#{ database } \s*#{ user } \s*#{ method }\s*$/ }
            elsif database != nil || user != nil || method != nil
              raise "pg_hba.confの確認にはパラメータPostgreSQL.authentication.records.x.{database,user,method}が必要です"
            end
          else
            if database != nil && user != nil && address != nil && method != nil
              its(:content) { should match /^#{ type } \s*#{ database } \s*#{ user } \s*#{ Regexp.escape(address) } \s*#{ method }\s*$/ }
            elsif database != nil || user != nil || address != nil || method != nil
              raise "pg_hba.confの確認にはパラメータPostgreSQL.authentication.records.x.{database,user,address,method}が必要です"
            end
          end
        end
      end
    end
  else
    raise "pg_hba.confの確認にはパラメータPostgreSQL.versionが必要です"
  end
end
