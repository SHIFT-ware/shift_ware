describe ("postgreSQL(Replication)") do
  password = property[:PostgreSQL][:db_user][:password] rescue nil
  server_role = property[:PostgreSQL][:cluster][:server_role] rescue nil

  if server_role != nil
    if password != nil
      describe command("su - postgres -c 'PGPASSWORD=#{ password } psql -Atw -c \"SELECT pg_is_in_recovery();\"'") do
        case server_role
        when "master"
          describe ("コマンドの返り値がfであること（リカバリモードになっていないこと）") do
            its(:stdout) { should eq "f\n" }
          end
        when "slave"
          describe ("コマンドの返り値がtであること（リカバリモードになっていること）") do
            its(:stdout) { should eq "t\n" }
          end
        else
          raise "パラメータserver_roleの値が不正です"
        end
      end
    else
      raise "サーバの役割を確認するにはパラメータPostgreSQL.db_user.passwordが必要です"
    end
  end

  case server_role
  when "slave"
    slave_name = property[:PostgreSQL][:cluster][:slave_name] rescue nil
    master_address = property[:PostgreSQL][:cluster][:master_address] rescue nil
    master_port = property[:PostgreSQL][:cluster][:master_port] rescue nil
    if slave_name != nil && password != nil && master_address != nil && master_port != nil
      test_cmd = <<-EOF
        su - postgres -c \\
          'PGPASSWORD=#{ password } psql -h #{ master_address } -p #{ master_port } \\
          -Atw -c \"SELECT application_name, sync_state FROM pg_stat_replication;\"'
      EOF
      describe command(test_cmd) do
        describe ("コマンドの返り値に#{ slave_name }のレコードが含まれていること") do
          its(:stdout) { should match /#{ Regexp.escape(slave_name) }/ }
        end
      end
    else
      raise "スレーブサーバのDB同期状態を確認するにはパラメータPostgreSQL.cluster.{slave_name,master_address,master_port}が必要です"
    end

    version = property[:PostgreSQL][:version] rescue nil
    if version != nil 
      describe file("/var/lib/pgsql/#{ version }/data/recovery.conf") do
        describe ("ファイルが存在していること") do
          it { should be_file }
        end

        describe ("のprimary_conninfoの値に") do
          describe ("host=#{ master_address }（MasterサーバのIPアドレス）が記載されていること"), :if => master_address != nil do
            its(:content) { should match /^primary_conninfo.*\s?'?host\s*=\s*#{ Regexp.escape(master_address) }\s?'?/ }
          end
          describe ("port=#{ master_port }が記載されていること"), :if => master_port != nil do
            its(:content) { should match /^primary_conninfo.*\s?'?port\s*=\s*#{ master_port }\s?'?/ }
          end
          describe ("application_name=#{ slave_name }が記載されていること"), :if => slave_name != nil do
            its(:content) { should match /^primary_conninfo.*\s?'?application_name\s*=\s*#{ slave_name }\s?'?/ }
          end

          name = property[:PostgreSQL][:cluster][:replication_user][:name] rescue nil
          describe ("user=#{ name }が記載されていること"), :if => name != nil do
            its(:content) { should match /^primary_conninfo.*\s?'?user\s*=\s*#{ name }\s?'?/ }
          end

          password = property[:PostgreSQL][:cluster][:replication_user][:password] rescue nil
          describe ("password=#{ password }が記載されていること"), :if => password != nil do
            its(:content) { should match /^primary_conninfo.*\s?'?password\s*=\s*#{ password }\s?'?/ }
          end
        end
      end
    else
      raise "recovery.confを確認するにはパラメータPostgreSQL.versionが必要です"
    end
  when "master"
  when nil
  else
    raise "パラメータserver_roleの値が不正です"
  end 
end
