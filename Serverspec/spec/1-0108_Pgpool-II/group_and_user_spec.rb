describe ("1-0108_Pgpool-II(group and user)") do
  exec_groups = property[:Pgpool][:exec_groups] rescue nil
  describe ("サービス起動ユーザ所属プライマリグループ") do
    next exec_groups == nil

    name = exec_groups[:primary][:name] rescue nil
    if name != nil
      describe group(name) do
        describe ("が存在すること") do
          it { should exist }
        end
        
        gid = exec_groups[:primary][:gid] rescue nil
        describe ("のgidが#{ gid }であること"), :if => gid != nil do
          it { should have_gid gid }
        end
      end
    else
      raise "テストに必要なパラメータPgpool.exec_groups.primary.nameが不足しています"
    end
  end

  describe ("サービス起動ユーザ所属セカンダリグループ") do
    next exec_groups == nil

    secondary Array(property[:Pgpool][:exec_groups][:secondary]) rescue []
    secondary.each do |sec_grp|
      name = sec_grp[:name] rescue nil
      if name != nil
        describe group(name) do
          describe ("が存在すること") do
            it { should exist }
          end

          gid = sec_grp[:gid] rescue nil
          describe ("のgidが#{ gid }であること"), :if => gid != nil do
            it { should have_gid gid }
          end
        end
      else
        raise "テストに必要なパラメータPgpool.exec_groups.secondary.x.nameが不足しています"
      end
    end
  end

  describe ("サービス起動ユーザ") do
    exec_user = property[:Pgpool][:exec_user] rescue nil

    next if exec_user == nil

    name = exec_user[:name] rescue nil
    if name != nil
      describe user(name) do
        describe ("が存在すること") do
          it { should exist }
        end

        uid = exec_user[:uid] rescue nil
        describe ("のuidが#{ uid }であること"), :if => uid != nil do
          it { should have_uid uid }
        end

        pri_name = property[:Pgpool][:exec_groups][:primary][:name] rescue nil
        describe ("の所属プライマリグループが#{ pri_name }であること"), :if => pri_name != nil do
          it { should belong_to_primary_group pri_name }
        end

        secondary = Array(property[:Pgpool][:exec_groups][:secondary]) rescue []
        secondary.each do |sec_grp|
          sec_name = sec_grp[:name] rescue nil
          describe ("の所属セカンダリグループが#{ sec_name }であること"), :if => sec_name != nil do
            it { should belong_to_group sec_name }
          end
        end

        home_dir = exec_user[:home_dir] rescue nil
        describe ("のホームディレクトリが#{ home_dir }であること"), :if => home_dir != nil do
          it { should have_home_directory home_dir }
        end

        shell = exec_user[:shell] rescue nil
        describe ("のログインシェルが#{ shell }であること"), :if => shell != nil do
          it { should have_login_shell shell }
        end
      end

      describe file("/etc/init.d/pgpool") do
        describe ("pgpoolの実行ユーザが#{ name }であること") do
          its(:content) { should match /^PGPOOLUSER=#{ name }$/ }
        end
      end
    else
      raise "テストに必要なパラメータPgpool.exec_user.nameが不足しています"
    end
  end
end
