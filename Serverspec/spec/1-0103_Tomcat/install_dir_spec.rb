describe ("1-0103_Tomcat(install dir)") do
  describe ("tomcatのインストールディレクトリ") do
    install_dir = property[:Tomcat][:install_dir] rescue nil

    next if install_dir == nil

    describe file(install_dir) do
      describe ("が存在すること") do
        it { should exist }
      end

      name = property[:Tomcat][:exec_user][:name] rescue nil

      case name
      when nil
        raise "テストに必要なパラメータTomcat.exec_user.nameが不足しています"
      else 
        describe ("の所有者が#{ name }であること") do
          it { should be_owned_by name } 
        end
      end
    end
  end
end
