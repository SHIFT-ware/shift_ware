describe ("1-0103_Tomcat(app)") do
  man_enable = property[:Tomcat][:manager][:enable] rescue nil
  install_dir = property[:Tomcat][:install_dir] rescue nil

  if install_dir == nil
    raise "マネージャアプリケーション群の存在確認にはパラメータTomcat.install_dirの設定が必要です" if man_enable != nil
  else
    describe ("マネージャアプリケーション群が存在すること"), :if => man_enable == true do
      describe file("#{ install_dir }/webapps/manager") do
        it { should exist }
      end
      describe file("#{ install_dir }/webapps/host-manager") do
        it { should exist }
      end
    end

    describe ("マネージャアプリケーション群が存在しないこと"), :if => man_enable == false do
      describe file("#{ install_dir }/webapps/manager") do
        it { should_not exist }
      end
      describe file("#{ install_dir }/webapps/host-manager") do
        it { should_not exist }
      end
    end
  end

  describe ("マネージャアプリケーション設定") do
    manager = property[:Tomcat][:manager] rescue nil
    
    next if manager == nil

    install_dir = property[:Tomcat][:install_dir] rescue nil
    if install_dir != nil
      describe file("#{ install_dir }/conf/tomcat-users.xml") do
        content = Specinfra.backend.run_command("cat #{ install_dir }/conf/tomcat-users.xml").stdout
        content.gsub!(/<!--.*?-->/m, '')
        content.gsub!(/\s*\n+/, "\n")

        user = manager[:user] rescue nil 
        describe ("の内、管理者ユーザが#{ user }であること"), :if => user != nil do
          it { content.should match /username="#{ user }"/ } 
        end

        password = manager[:password] rescue nil
        describe ("の内、管理者ユーザのパスワードが#{ password }であること"), :if => password != nil do
          it { content.should match /password="#{ password }"/ } 
        end

        gui = manager[:enable_roles][:gui] rescue nil
        describe ("の内、管理者ユーザのロールmanager-guiが有効であること"), :if => gui == true do
          it { content.should match /roles=".*(,|)manager-gui(,|).*"/ } 
        end
        describe ("の内、管理者ユーザのロールmanager-guiが無効であること"), :if => gui == false do
          it { content.should_not match /roles=".*(,|)manager-gui(,|).*"/ } 
        end

        status = manager[:enable_roles][:status] rescue nil
        describe ("の内、管理者ユーザのロールmanager-statusが有効であること"), :if => status == true do
          it { content.should match /roles=".*(,|)manager-status(,|).*"/ } 
        end
        describe ("の内、管理者ユーザのロールmanager-statusが無効であること"), :if => status == false do
          it { content.should_not match /roles=".*(,|)manager-status(,|).*"/ } 
        end

        script_role = manager[:enable_roles][:script_role] rescue nil
        describe ("の内、管理者ユーザのロールmanager-scriptが有効であること"), :if => script_role == true do
          it { content.should match /roles=".*(,|)manager-script(,|).*"/ } 
        end
        describe ("の内、管理者ユーザのロールmanager-scriptが無効であること"), :if => script_role == false do
          it { content.should_not match /roles=".*(,|)manager-script(,|).*"/ } 
        end

        jmx_role = manager[:enable_roles][:jmx_role] rescue nil
        describe ("の内、管理者ユーザのロールmanager-jmxが有効であること"), :if => jmx_role == true do
          it { content.should match /roles=".*(,|)manager-jmx(,|).*"/ } 
        end
        describe ("の内、管理者ユーザのロールmanager-jmxが無効であること"), :if => jmx_role == false do
          it { content.should_not match /roles=".*(,|)manager-jmx(,|).*"/ } 
        end
      end
    else
      raise "マネージャアプリケーション設定のテストにはパラメータTomcat.install_dirの設定が必要です"
    end
  end

  ini_enable = property[:Tomcat][:initial_apps][:enable] rescue nil
  install_dir = property[:Tomcat][:install_dir] rescue nil

  if install_dir == nil
    raise "初期アプリケーション群の存在確認にはパラメータTomcat.install_dirの設定が必要です" if ini_enable != nil
  else
    describe ("初期アプリケーション群が存在すること"), :if => ini_enable == true do
      describe file("#{ install_dir }/webapps/docs") do
        it { should exist }
      end
      describe file("#{ install_dir }/webapps/examples") do
        it { should exist }
      end
    end

    describe ("初期アプリケーション群が存在しないこと"), :if => ini_enable == false do
      describe file("#{ install_dir }/webapps/docs") do
        it { should_not exist }
      end
      describe file("#{ install_dir }/webapps/examples") do
        it { should_not exist }
      end
    end
  end
end 
