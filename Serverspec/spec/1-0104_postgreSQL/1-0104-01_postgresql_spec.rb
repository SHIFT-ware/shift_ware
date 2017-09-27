describe ("postgreSQL") do
  describe ("サービス起動ユーザ所属プライマリグループ") do
    describe group('postgres') do
      gid = property[:PostgreSQL][:exec_groups][:primary][:gid] rescue nil
      describe ("のgidが#{ gid }であること"), :if => gid != nil do
        it { should have_gid gid }
      end
    end

    describe ("サービス起動ユーザ所属セカンダリグループ") do
      secondary = Array(property[:PostgreSQL][:exec_groups][:secondary]) rescue []
      secondary.each do |secondary_group|
        name = secondary_group[:name] rescue nil
        case name
        when nil
          raise "グループのテストにはパラメータPostgreSQL.exec_groups.secondary.x.nameが必要です"
        else
          describe group(name) do
            describe ("が存在すること") do
              it { should exist }
            end

            gid = secondary_group[:gid] rescue nil
            describe ("のgidが#{ gid }であること"), :if => gid != nil do
              it { should have_gid gid }
            end
          end
        end
      end
    end
  end

  exec_user = property[:PostgreSQL][:exec_user] rescue nil
  if exec_user != nil
    describe user("postgres") do
      describe ("が存在すること") do
        it { should exist }
      end
  
      uid = exec_user[:uid] rescue nil
      describe ("のuidが#{ uid }であること"), :if => uid != nil do
        it { should have_uid uid }
      end
  
      exec_groups = property[:PostgreSQL][:exec_groups] != nil
       
      describe ("の所属プライマリグループがpostgresであること"), :if => exec_groups != nil  do
        it { should belong_to_primary_group "postgres" }
      end
  
      secondary = Array(exec_groups[:secondary]) rescue []
      secondary.each do |secondary_group|
        name = secondary_group[:name] rescue nil
        describe ("の所属セカンダリグループが#{ name }であること"), :if => name != nil do
         it { should belong_to_group name }
        end
      end
  
      shell = exec_user[:shell] rescue nil
      describe ("のログインシェルが#{ shell }であること"), :if => shell != nil do
        it { should have_login_shell shell }
      end
    end
  end

  version = property[:PostgreSQL][:version] rescue nil
  case version
  when nil
    raise "パッケージのインストール確認およびインストールディレクトリの確認にはパラメータPostgreSQL.versionが必要です"
  else
    describe package("postgresql#{ property[:PostgreSQL][:version].sub('.', '') }") do
      describe ("postgresql#{ version.sub('.', '') }がインストールされていること") do
        it { should be_installed }
      end
    end
    describe package("postgresql#{ property[:PostgreSQL][:version].sub('.', '') }-server") do
      describe ("postgresql#{ version.sub('.', '') }-serverがインストールされていること") do
        it { should be_installed }
      end
    end
    describe file("/var/lib/pgsql/#{ version }") do
      describe ("ディレクトリが存在していること") do
        it { should be_directory }
      end
    end
  end

  describe file("/var/lib/pgsql/.bash_profile") do
    describe ("にexport PGDATA=#{ "/var/lib/pgsql" }/#{ version }/dataが記載されていること"), :if => version != nil do
      its(:content) { should match /^export PGDATA=#{ Regexp.escape("/var/lib/pgsql") }\/#{ Regexp.escape(version) }\/data/ }
    end
    describe ("にexport PATH=/usr/pgsql-#{ version }/bin/:$PATHが記載されていること"), :if => version != nil do
      its(:content) { should match /^export PATH=\/usr\/pgsql-#{ Regexp.escape(version) }\/bin\/:\$PATH/ }
    end
    describe ("にexport LD_LIBRARY_PATH=/usr/pgsql-#{ version }/lib:$LD_LIBRARY_PATHが記載されていること"), :if => version != nil do
      its(:content) { should match /^export LD_LIBRARY_PATH=\/usr\/pgsql-#{ Regexp.escape(version) }\/lib:\$LD_LIBRARY_PATH/ }
    end
  end

  wal_archive_dir = property[:PostgreSQL][:wal_archive_dir] rescue nil
  describe ("WALアーカイブディレクトリ") do
    describe file("#{ wal_archive_dir }"), :if => wal_archive_dir != nil do
      describe ("ディレクトリが存在していること") do
        it { should be_directory }
      end
    end
  end

  describe service("postgresql-#{ version }"), :if => version != nil do
    state = property[:PostgreSQL][:state] rescue nil
    case state
    when "started"
      describe ("サービスが稼働していること") do
        it { should be_running }
      end
    when "stopped"
      describe ("サービスが停止していること") do
        it { should_not be_running }
      end
    when nil
    else
      raise "パラメータPostgreSQL.stateの値が不正です"
    end

    enabled = property[:PostgreSQL][:enabled] rescue nil
    case enabled
    when true
      context ("サービスの自動起動設定がenabledになっていること") do
        it { should be_enabled }
      end
    when false
      context ("サービスの自動起動設定がdisabledになっていること")  do
        it { should_not be_enabled }
      end
    end
  end
end
