describe ("1-0103_Tomcat(user and group)") do
  describe ("サービス起動ユーザ所属プライマリグループ") do
    primary = property[:Tomcat][:exec_groups][:primary] rescue nil

    next primary == nil

    pri_name = primary[:name] rescue nil
    if pri_name != nil
      describe group(pri_name) do
        describe ("が存在すること") do
          it { should exist }
        end

        pri_gid = primary[:gid] rescue nil
        describe ("のgidが#{ pri_gid }であること"), :if => pri_gid != nil do
          it { should have_gid pri_gid }
        end
      end
    else
      raise "テストに必要なパラメータTomcat.exec_groups.primary.nameが不足しています"
    end
  end

  describe ("サービス起動ユーザ所属セカンダリグループ") do
    secondarys = Array(property[:Tomcat][:exec_groups][:secondary]) rescue []

    secondarys.each do |secondary|
      sec_name = secondary[:name] rescue nil
      if sec_name != nil
        describe group(sec_name) do
          describe ("が存在すること") do
            it { should exist }
          end

          sec_gid = secondary[:gid] rescue nil
          describe ("のgidが#{ sec_gid }であること"), :if => sec_gid != nil do
            it { should have_gid sec_gid }
          end
        end
      else
        raise "テストに必要なパラメータTomcat.exec_groups.secondary.x.nameが不足しています"
      end
    end
  end

  describe ("サービス起動ユーザ") do
    exec_user = property[:Tomcat][:exec_user] rescue nil

    next if exec_user == nil

    usr_name = exec_user[:name] rescue nil
    if usr_name != nil
      describe user(usr_name) do
        describe ("が存在すること") do
          it { should exist }
        end

        uid = exec_user[:uid] rescue nil
        describe ("のuidが#{ uid }であること"), :if => uid != nil do
          it { should have_uid uid }
        end

        pri_name = property[:Tomcat][:exec_groups][:primary][:name] rescue nil 
        describe ("の所属プライマリグループが#{ pri_name }であること"), :if => pri_name != nil do
          it { should belong_to_primary_group pri_name }
        end

        secondarys = Array(property[:Tomcat][:exec_groups][:secondary]) rescue [] 
        secondarys.each do |secondary|
          sec_name = secondary[:name]
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
    else
      raise "テストに必要なパラメータTomcat.exec_user.nameが不足しています"
    end
  end
end

