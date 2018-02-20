describe ("1-0102_apache(common)") do
  describe ("サービス起動ユーザ所属プライマリグループ") do
    name = property[:apache][:exec_groups][:primary][:name] rescue nil
    gid = property[:apache][:exec_groups][:primary][:gid] rescue nil

    next if name == nil && gid == nil
    raise "テストに必要なパラメータapache.exec_groups.primary.nameが不足しています" if name == nil

    describe group(name) do
      describe ("が存在すること") do
        it { should exist }
      end

      describe ("のgidが#{ gid }であること"), :if => gid != nil do
        it { should have_gid gid }
      end
    end
  end


  describe ("サービス起動ユーザ所属セカンダリグループ") do
    secondaries = Array(property[:apache][:exec_groups][:secondary]) rescue []

    secondaries.each do |secondary|
      name = secondary[:name] rescue nil
      gid = secondary[:gid] rescue nil

      next if name == nil && gid == nil
      raise "テストに必要なパラメータapache.exec_groups.secondary.nameが不足しています" if name == nil

      describe group(name) do
        describe ("が存在すること") do
          it { should exist }
        end

        describe ("のgidが#{ gid }であること"), :if => gid != nil do
          it { should have_gid gid }
        end
      end
    end
  end


  describe ("起動ユーザ") do
    exec_user = property[:apache][:exec_user][:name] rescue nil
    exec_uid = property[:apache][:exec_user][:uid] rescue nil
    exec_primary_group = property[:apache][:exec_groups][:primary][:name] rescue nil
    exec_secondary_groups = Array(property[:apache][:exec_groups][:secondary]) rescue []
    exec_home_dir = property[:apache][:exec_user][:home_dir] rescue nil
    exec_shell = property[:apache][:exec_user][:shell] rescue nil

    should_skip = [exec_user, exec_uid, exec_primary_group, exec_secondary_groups, exec_home_dir, exec_shell].flatten.all? &:nil?
    next if should_skip
    raise "テストに必要なパラメータapache.exec_user.nameが不足しています" if exec_user == nil

    describe user(exec_user) do
      describe ("が存在すること") do
        it { should exist }
      end
      describe ("のuidが#{ exec_uid }であること"), :if => exec_uid != nil do
        it { should have_uid exec_uid }
      end
      describe ("の所属プライマリグループが#{ exec_primary_group }であること"), :if => exec_primary_group != nil do
        it { should belong_to_primary_group exec_primary_group }
      end
      exec_secondary_groups.each do |secondary|
        describe ("の所属セカンダリグループが#{ secondary[:name] }であること"), :if => secondary[:name] != nil do
          it { should belong_to_group secondary[:name] }
        end
      end
      describe ("のホームディレクトリが#{ exec_home_dir }であること"), :if => exec_home_dir != nil do
        it { should have_home_directory exec_home_dir }
      end
      describe ("のログインシェルが#{ exec_shell }であること"), :if => exec_shell != nil do
        it { should have_login_shell exec_shell }
      end
    end
  end


  describe package('httpd') do
    describe ("がインストールされていること") do
      it { should be_installed }
    end
  end


  describe service('httpd') do
    state = property[:apache][:state] rescue nil
    describe ("の起動状態が#{ state }であること") do
      case state
      when "started"
        it { should be_running }
      when "stopped"
        it { should_not be_running }
      else
        raise "apache.stateの値が不正です" if state != nil
      end
    end

    enabled = property[:apache][:enabled] rescue nil

    describe ("のサービスの自動起動設定が#{ enabled }であること"), :if => enabled != nil do
      if enabled
        it { should be_enabled }
      else
        it { should_not be_enabled }
      end
    end
  end


  describe file('/etc/httpd/conf/httpd.conf') do
    type = property[:apache][:mpm][:type] rescue nil

    case type
    when "worker"
      describe ("中でMPM workerモジュールをロードする設定になっていること") do
        it { should contain("^LoadModule \s*mpm_worker_module \s*modules/mod_mpm_worker.so\s*$") }
      end
    when "prefork"
      describe ("中でMPM preforkモジュールをロードする設定になっていること") do
        it { should contain("^LoadModule \s*mpm_prefork_module \s*modules/mod_mpm_prefork.so\s*$") }
      end
    else
      raise "apache.mpm.typeの値が不正です" if type != nil
    end

    listens = Array(property[:apache][:Listen]) rescue []
    listens.each do |listen|
      describe ("中でListenの値が#{ listen[:port] }であること") do
        it { should contain("^Listen \s*#{ listen[:port] }\s*$") }
      end
    end

    server_name = property[:apache][:ServerName] rescue nil
    describe ("中でServerNameの値が#{ server_name }であること"), :if => server_name != nil do
      it { should contain("^ServerName \s*#{ server_name }\s*$") }
    end

    document_root = property[:apache][:DocumentRoot] rescue nil
    describe ("中でDocumentRootの値が#{ document_root }であること"), :if => document_root != nil do
      it { should contain("^DocumentRoot \s*#{ document_root }\s*$") }
    end

    server_admin = property[:apache][:ServerAdmin] rescue nil
    describe ("中でServerAdminの値が#{ server_admin }であること"), :if => server_admin != nil do
      it { should contain("^ServerAdmin \s*#{ server_admin }\s*$") }
    end

    error_log = property[:apache][:ErrorLog] rescue nil
    describe ("中でErrorLogの値が#{ error_log }であること"), :if => error_log != nil do
      it { should contain("^\s*ErrorLog \s*#{ error_log }\s*$") }
    end

    custom_log = property[:apache][:CustomLog] rescue nil
    describe ("中でCustomLogの値が#{ custom_log }であること"), :if => custom_log != nil do
      it { should contain("^\s*CustomLog \s*#{ custom_log }\s*$") }
    end
  end

  describe file('/etc/httpd/conf/extra/httpd-autoindex.conf') do
    enable_followsymlinks = property[:apache][:autoindex][:enable_followsymlinks] rescue nil
    case enable_followsymlinks
    when true
      describe ("中で/var/www/iconsディレクトリに対し、FollowSymLinksが有効になっていること") do
        it { should contain("^\s*Options\s*.*\s*FollowSymLinks\s*") }
      end
    when false
      describe ("中で/var/www/iconsディレクトリに対し、FollowSymLinksが無効になっていること") do
        it { should_not contain("^\s*Options\s*.*\s*FollowSymLinks\s*") }
      end
    end
  end

  describe file('/etc/httpd/conf/extra/httpd-mpm.conf') do
    type = property[:apache][:mpm][:type] rescue nil

    case type
    when "worker"
      worker = property[:apache][:mpm][:worker] rescue nil
      next if worker == nil

      describe ("中でThreadLimitの値が#{ worker[:ThreadLimit] }であること") , :if => worker[:ThreadLimit] != nil do
        it { should contain(/^\s*ThreadLimit \s*#{ worker[:ThreadLimit] }\s*$/).from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でStartServersの値が#{ worker[:StartServers] }であること") , :if => worker[:StartServers] != nil do
        it { should contain("^\s*StartServers \s*#{ worker[:StartServers] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxClientsの値が#{ worker[:MaxClients] }であること") , :if => worker[:MaxClients] != nil do
        it { should contain("^\s*MaxClients \s*#{ worker[:MaxClients] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でThreadsPerChildの値が#{ worker[:ThreadsPerChild] }であること") , :if => worker[:ThreadsPerChild] != nil do
        it { should contain("^\s*ThreadsPerChild \s*#{ worker[:ThreadsPerChild] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxRequestsPerChildの値が#{ worker[:MaxRequestsPerChild] }であること") , :if => worker[:MaxRequestsPerChild] != nil do
        it { should contain("^\s*MaxRequestsPerChild \s*#{ worker[:MaxRequestsPerChild] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMinSpareThreadsの値が#{ worker[:MinSpareThreads] }であること") , :if => worker[:MinSpareThreads] != nil do
        it { should contain("^\s*MinSpareThreads \s*#{ worker[:MinSpareThreads] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxSpareThreadsの値が#{ worker[:MaxSpareThreads] }であること") , :if => worker[:MaxSpareThreads] != nil do
        it { should contain("^\s*MaxSpareThreads \s*#{ worker[:MaxSpareThreads] }\s*$").from(/^<IfModule mpm_worker_module>/).to(/^<\/IfModule>/) }
      end
    when "prefork"
      prefork = property[:apache][:mpm][:prefork] rescue nil
      next if prefork == nil

      describe ("中でStartServersの値が#{ prefork[:StartServers] }であること") , :if => prefork[:StartServers] != nil do
        it { should contain("^\s*StartServers \s*#{ prefork[:StartServers] }\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMinSpareServersの値が#{ prefork[:MinSpareServers] }であること") , :if => prefork[:MinSpareServers] != nil do
        it { should contain("^\s*MinSpareServers \s*#{prefork[:MinSpareServers]}\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxSpareServersの値が#{ prefork[:MaxSpareServers] }であること") , :if => prefork[:MaxSpareServers] != nil do
        it { should contain("^\s*MaxSpareServers \s*#{ prefork[:MaxSpareServers] }\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でServerLimitの値が#{ prefork[:ServerLimit] }であること") , :if => prefork[:ServerLimit] != nil do
        it { should contain("^\s*ServerLimit \s*#{ prefork[:ServerLimit] }\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxClientsの値が#{ prefork[:MaxClients] }であること") , :if => prefork[:MaxClients] != nil do
        it { should contain("^\s*MaxClients \s*#{ prefork[:MaxClients] }\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
      describe ("中でMaxRequestsPerChildの値が#{ prefork[:MaxRequestsPerChild] }であること") , :if => prefork[:MaxRequestsPerChild] != nil do
        it { should contain("^\s*MaxRequestsPerChild \s*#{ prefork[:MaxRequestsPerChild] }\s*$").from(/^<IfModule mpm_prefork_module>/).to(/^<\/IfModule>/) }
      end
    else
      raise "apache.mpm.typeの値が不正です" if type != nil 
    end
  end


  describe file('/etc/httpd/conf/extra/httpd-default.conf') do

    timeout = property[:apache][:timeout] rescue nil
    describe ("中でTimeoutの値が#{ timeout }であること") , :if => timeout != nil do
      it { should contain("^Timeout \s*#{ timeout }\s*$") }
    end

    keepalive = property[:apache][:KeepAlive] rescue nil
    describe ("中でKeepAliveの値が#{ keepalive }であること") , :if => keepalive != nil do
      it { should contain("^KeepAlive \s*#{ keepalive }\s*$") }
    end

    max_keepalive_requests = property[:apache][:MaxKeepAliveRequests] rescue nil
    describe ("中でMaxKeepAliveRequestsの値が#{ max_keepalive_requests }であること") , :if => max_keepalive_requests != nil do
      it { should contain("^MaxKeepAliveRequests \s*#{ max_keepalive_requests }\s*$") }
    end

    keepalive_timeout = property[:apache][:KeepAliveTimeout] rescue nil
    describe ("中でKeepAliveTimeoutの値が#{ keepalive_timeout }であること") , :if => keepalive_timeout != nil do
      it { should contain("^KeepAliveTimeout \s*#{ keepalive_timeout }\s*$") }
    end

    server_tokens = property[:apache][:ServerTokens] rescue nil
    describe ("中でServerTokensの値が#{ server_tokens }であること") , :if => server_tokens != nil do
      it { should contain("^ServerTokens \s*#{ server_tokens }\s*$") }
    end
  end

  describe file('/etc/httpd/conf/extra/httpd-info.conf') do
    status = property[:apache][:visible_server_status] rescue nil
    info = property[:apache][:visible_server_info] rescue nil
    addresses = Array(property[:apache][:accessible_addresses]) rescue []
    if addresses.first == { "address" => "0.0.0.0" }
      describe ("中で<Location /server-status>にRequire all grantedが指定されていること"), :if => status == true do
        it { should contain("^\s*Require \s*all \s*granted\s*$").from(/^<Location \/server-status>/).to(/^<\/Location>/) }
      end

      describe ("中で<Location /server-info>にRequire all grantedが指定されていること"), :if => info == true do
        it { should contain("^\s*Require \s*all \s*granted\s*$").from(/^<Location \/server-info>/).to(/^<\/Location>/) }
      end
    else
      addresses.each do |address|
        describe ("中で<Location /server-status>にRequire ip #{ address[:address] }が指定されていること"), :if => status == true do
          it { should contain("^\s*Require \s*ip \s*#{ address[:address] }\s*$").from(/^<Location \/server-status>/).to(/^<\/Location>/) }
        end

        describe ("中で<Location /server-info>にRequire ip #{ address[:address] }が指定されていること"), :if => info == true do
          it { should contain("^\s*Require \s*ip \s*#{ address[:address] }\s*$").from(/^<Location \/server-info>/).to(/^<\/Location>/) }
        end
      end
    end

    describe ("中で<Location /server-status>にRequire ip 127が指定されていること"), :if => status == false do
      it { should contain("^\s*Require \s*ip \s*127\s*$").from(/^<Location \/server-status>/).to(/^<\/Location>/) }
    end
    describe ("中で<Location /server-info>にRequire ip 127が指定されていること"), :if => info == false do
      it { should contain("^\s*Require \s*ip \s*127\s*$").from(/^<Location \/server-info>/).to(/^<\/Location>/) }
    end
  end

  describe file('/etc/httpd/conf/extra/httpd-languages.conf') do
    utf8 = property[:apache][:is_default_charset_utf8] rescue nil
    describe ("中でAddDefaultCharsetにUTF-8が指定されていること"), :if => utf8 == true do
      it { should contain("^AddDefaultCharset \s*UTF-8\s*$") }
    end

    describe ("中でAddDefaultCharsetにUTF-8が指定されていないこと"), :if => utf8 == false do
      it { should_not contain("^AddDefaultCharset \s*UTF-8\s*$") }
    end 

    language = property[:apache][:is_1st_prior_language_ja] rescue nil
    describe ("中でLanguagePriorityにおいてjaの優先度が1番になっていること"), :if => language == true do
      it { should contain("^LanguagePriority \s*ja .*$") }
    end

    describe ("中でLanguagePriorityにおいてjaの優先度が1番になっていないこと"), :if => language == false do
      it { should_not contain("^LanguagePriority \s*ja .*$") }
    end
  end

  describe file('/etc/httpd/conf/extra/httpd-userdir.conf') do
    disable_userdir = property[:apache][:disable_userdir] rescue nil
    describe ("中でUserDirにdisabledが指定されていること"), :if => disable_userdir == true do
      it { should contain("^UserDir \s*disabled\s*$") }
    end

    describe ("中でUserDirにdisabledが指定されていないこと"), :if => disable_userdir == false do
      it { should_not contain("^UserDir \s*disabled\s*$") }
    end
  end
end

