describe ("postgreSQL(config)") do
  conf_file_md5 = property[:PostgreSQL][:postgresql_conf][:conf_file_md5] rescue nil
  version = property[:PostgreSQL][:version] rescue nil
  if conf_file_md5 != nil && version != nil
    describe file("/var/lib/pgsql/#{ version }/data/postgresql.conf") do
      describe ("のMD5値が#{ conf_file_md5 }であること") do
        its(:md5sum) { should eq "#{ conf_file_md5 }" }
      end
    end
  else
    raise "postgresql.confのMD5値確認にはパラメータPostgreSQL.postgresql_conf.conf_file_md5が必要です"
  end
end
