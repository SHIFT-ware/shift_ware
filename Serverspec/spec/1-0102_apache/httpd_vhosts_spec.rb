describe ("1-0102_apache(vhosts)") do
  virtualhost = property[:apache][:virtualhost] rescue nil
  next if virtualhost == nil


  describe file("/etc/httpd/conf/httpd.conf") do
    describe ("中で/etc/httpd/conf/extra/httpd-vhosts.confをインクルードする設定になっていること") do
      it { should contain("^Include /etc/httpd/conf/extra/httpd-vhosts.conf$") }
    end
  end

  vhosts = Array(virtualhost[:vhosts]) rescue []
  ssl_vhosts = Array(virtualhost[:ssl_vhosts]) rescue []
  describe file("/etc/httpd/conf/extra/httpd-vhosts.conf") do
    content = Specinfra.backend.run_command("cat /etc/httpd/conf/extra/httpd-vhosts.conf").stdout
    content.gsub!(/^#.*$/, '')
    content.gsub!(/\s*\n+/, "\n")

    vhosts_conf = content.scan(/<VirtualHost\s+.*?>.*?<\/VirtualHost>/m)

    vhosts.each do |vhost|
      raise "テストに必要なパラメータapache.virtualhost.vhosts.x.ServerNameが不足しています" if vhost[:ServerName] == nil
      vhost_setting = vhosts_conf.find do |conf| 
        conf.match(/^\s*ServerName\s+#{ vhost[:ServerName] }(\s|$)/)
      end

      describe ("VirtualHost #{ vhost[:ServerName] }") do
        describe ("のServerNameが#{ vhost[:ServerName] }であること") do
          it { vhost_setting.should match /^\s*ServerName \s*#{ vhost[:ServerName] }(\s|$)/ }
        end
        describe ("のDocumentRootが#{ vhost[:DocumentRoot] }であること"), :if => vhost[:DocumentRoot] != nil do
          it { vhost_setting.should match /^\s*DocumentRoot \s*#{ vhost[:DocumentRoot] }(\s|$)/ }
        end
        describe ("のServerAdminが#{ vhost[:ServerAdmin] }であること"), :if => vhost[:ServerAdmin] != nil do
          it { vhost_setting.should match /^\s*ServerAdmin \s*#{ vhost[:ServerAdmin] }(\s|$)/ }
        end
        describe ("のServerAliasが#{ vhost[:ServerAlias] }であること"), :if => vhost[:ServerAlias] != nil do
          it { vhost_setting.should match /^\s*ServerAlias \s*#{ vhost[:ServerAlias] }(\s|$)/ }
        end
        describe ("のCustomLogが#{ vhost[:CustomLog] }であること"), :if => vhost[:CustomLog] != nil do
          it { vhost_setting.should match /^\s*CustomLog \s*#{ vhost[:CustomLog] }(\s|$)/ }
        end
        describe ("のErrorLogが#{ vhost[:ErrorLog] }であること"), :if => vhost[:ErrorLog] != nil do
          it { vhost_setting.should match /^\s*ErrorLog \s*#{ vhost[:ErrorLog] }(\s|$)/ }
        end
        describe ("のポート指定が#{ vhost[:port] }であること"), :if => vhost[:port] != nil do
          it { vhost_setting.should match /^\s*<VirtualHost \*:#{ vhost[:port] }>(\s|$)/ }
        end
      end
    end

    ssl_vhosts.each do |ssl_vhost|
      raise "テストに必要なパラメータapache.virtualhost.ssl_vhosts.x.ServerNameが不足しています" if ssl_vhost[:ServerName] == nil
      vhost_conf = vhosts_conf.find do |conf|
        conf.match(/^\s*ServerName\s+#{ ssl_vhost[:ServerName] }(\s|$)/)
      end

      describe ("VirtualHost #{ ssl_vhost[:ServerName] }") do
        describe ("のServerNameが#{ ssl_vhost[:ServerName] }であること") do
          it { vhost_conf.should match /^\s*ServerName \s*#{ ssl_vhost[:ServerName] }(\s|$)/ }
        end
        describe ("のDocumentRootが#{ ssl_vhost[:DocumentRoot] }であること"), :if => ssl_vhost[:DocumentRoot] != nil do
          it { vhost_conf.should match /^\s*DocumentRoot \s*#{ ssl_vhost[:DocumentRoot] }(\s|$)/ }
        end
        describe ("のServerAdminが#{ ssl_vhost[:ServerAdmin] }であること"), :if => ssl_vhost[:ServerAdmin] != nil do
          it { vhost_conf.should match /^\s*ServerAdmin \s*#{ ssl_vhost[:ServerAdmin] }(\s|$)/ }
        end
        describe ("のServerAliasが#{ ssl_vhost[:ServerAlias] }であること"), :if => ssl_vhost[:ServerAlias] != nil do
          it { vhost_conf.should match /^\s*ServerAlias \s*#{ ssl_vhost[:ServerAlias] }(\s|$)/ }
        end
        describe ("のCustomLogが#{ ssl_vhost[:CustomLog] }であること"), :if => ssl_vhost[:CustomLog] != nil do
          it { vhost_conf.should match /^\s*CustomLog \s*#{ ssl_vhost[:CustomLog] }(\s|$)/ }
        end
        describe ("のErrorLogが#{ ssl_vhost[:ErrorLog] }であること"), :if => ssl_vhost[:ErrorLog] != nil do
          it { vhost_conf.should match /^\s*ErrorLog \s*#{ ssl_vhost[:ErrorLog] }(\s|$)/ }
        end
        describe ("のSSLEngineがonであること") do
          it { vhost_conf.should match /^\s*SSLEngine \s*on(\s|$)/ }
        end
        describe ("のSSLCertificateFileが#{ ssl_vhost[:SSLCertificateFile] }であること"), :if => ssl_vhost[:SSLCertificateFile] != nil do
          it { vhost_conf.should match /^\s*SSLCertificateFile \s*#{ ssl_vhost[:SSLCertificateFile] }(\s|$)/ }
        end
        describe ("のSSLCertificateKeyFileが#{ ssl_vhost[:SSLCertificateKeyFile] }であること"), :if => ssl_vhost[:SSLCertificateKeyFile] != nil do
          it { vhost_conf.should match /^\s*SSLCertificateKeyFile \s*#{ ssl_vhost[:SSLCertificateKeyFile] }(\s|$)/ }
        end
        describe ("のポート指定が#{ ssl_vhost[:port] }であること"), :if => ssl_vhost[:port] != nil do
          it { vhost_conf.should match /^\s*<VirtualHost \*:#{ ssl_vhost[:port] }>(\s|$)/ }
        end
      end
    end
  end

  describe package('mod_ssl'), :if => !ssl_vhosts.empty? do
    describe ("がインストールされていること") do
      it { should be_installed }
    end
  end

  describe file('/etc/httpd/conf/httpd.conf'), :if => !ssl_vhosts.empty? do 
    describe ("中でmod_sslモジュールをロードする設定になっていること") do
      its(:content) { should match "^LoadModule \s*ssl_module \s*modules/mod_ssl.so\s*$" }
    end
    describe ("中で/etc/httpd/conf/extra/httpd-ssl.confをインクルードする設定になっていること") do
      its(:content) { should match "^Include \s*/etc/httpd/conf/extra/httpd-ssl.conf\s*$" }
    end
  end

  ssl_vhosts.each do |ssl_vhost|
    if ssl_vhost[:SSLCertificateFile] != nil
      describe file(ssl_vhost[:SSLCertificateFile]) do
        describe ("というファイル名の証明書が存在すること") do
          it { should exist }
        end

        exec_user_name = property[:apache][:exec_user][:name] rescue nil
        describe ("の所有者が#{ exec_user_name }であること"), :if => exec_user_name != nil do
          it { should be_owned_by exec_user_name }
        end

        primary_name = property[:apache][:exec_groups][:primary][:name] rescue nil
        describe ("の所有グループが#{ primary_name }であること"), :if => primary_name != nil do
          it { should be_owned_by primary_name }
        end

        describe ("の権限が400であること") do
          it { should be_mode 400 }
        end
      end
    end

    if ssl_vhost[:SSLCertificateKeyFile] != nil
      describe file(ssl_vhost[:SSLCertificateKeyFile]) do
        describe ("というファイル名の秘密鍵が存在すること") do
          it { should exist }
        end

        exec_user_name = property[:apache][:exec_user][:name] rescue nil
        describe ("の所有者が#{ exec_user_name }であること"), :if => exec_user_name != nil  do
          it { should be_owned_by exec_user_name }
        end

        primary_name = property[:apache][:exec_groups][:primary][:name] rescue nil
        describe ("の所有グループが#{ primary_name }であること"), :if => primary_name != nil do
          it { should be_owned_by primary_name }
        end

        describe ("の権限が400であること") do
          it { should be_mode 400 }
        end
      end
    end
  end
end
