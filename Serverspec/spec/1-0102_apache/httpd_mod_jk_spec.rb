describe ("1-0102_apache(mod_jk)") do
  mod_jk = property[:apache][:mod_jk] rescue nil
  next if mod_jk == nil

  describe file('/etc/httpd/modules/mod_jk.so') do
    describe ("が存在すること") do
      it { should exist }
    end
  end

  describe file('/etc/httpd/conf.d/mod_jk.conf') do
    accessible_addresses = Array(property[:apache][:accessible_addresses]) rescue []
    raise "テストに必要なパラメータapache.accessible_addressesが不足しています" if accessible_addresses.empty?

    if accessible_addresses.first == { "address" => "0.0.0.0" }
      describe ("中で<Location /jkstatus/>にAllow from allが指定されていること") do
        it { should contain("^\s*Allow \s*from \s*all\s*$").from(/^<Location \/jkstatus\/>/).to(/^<\/Location>/) }
      end
    else
      accessible_addresses.each do |address|
        describe ("中で<Location /jkstatus/>にAllow from #{ address[:address] }が指定されていること") do
          it { should contain("^\s*Allow \s*from \s*#{ address[:address] }\s*$").from(/^<Location \/jkstatus\/>/).to(/^<\/Location>/) }
        end
      end
    end
  end

  describe file('/etc/httpd/conf.d/workers.properties') do
    ajp_port = mod_jk[:common_params][:ajp_port] rescue nil
    socket_timeout = mod_jk[:common_params][:socket_timeout] rescue nil
    socket_keepalive = mod_jk[:common_params][:socket_keepalive] rescue nil
    connection_pool_size = mod_jk[:common_params][:connection_pool_size] rescue nil
    connection_pool_minsize = mod_jk[:common_params][:connection_pool_minsize] rescue nil

    describe ("中でworker.template.portに#{ ajp_port }を指定していること"), :if => ajp_port != nil do
      it { should contain("^worker.template.port=#{ ajp_port }\s*$") }
    end
    describe ("中でworker.template.socket_timeoutに#{ socket_timeout }を指定していること"), :if => socket_timeout != nil do
      it { should contain("^worker.template.socket_timeout=#{ socket_timeout }\s*$") }
    end
    describe ("中でworker.template.socket_keepaliveに#{ socket_keepalive }を指定していること"), :if => socket_keepalive != nil do
      it { should contain("^worker.template.socket_keepalive=#{ socket_keepalive }\s*$") }
    end
    describe ("中でworker.template.connection_pool_sizeに#{ connection_pool_size }を指定していること"), :if => connection_pool_size != nil do
      it { should contain("^worker.template.connection_pool_size=#{ connection_pool_size }\s*$") }
    end
    describe ("中でworker.template.connection_pool_minsizeに#{ connection_pool_minsize }を指定していること"), :if => connection_pool_minsize != nil do
      it { should contain("^worker.template.connection_pool_minsize=#{ connection_pool_minsize }\s*$") }
    end

    describe ("中でworker.listにstatusを指定していること") do
      it { should contain("^worker.list=.*status.*$") }
    end
    describe ("中でworker.status.typeにstatusを指定していること") do
      it { should contain("^worker.status.type=status$") }
    end

    linked_ap_servers = Array(mod_jk[:linked_ap_servers]) rescue []
    linked_ap_servers.each do |server|
      describe ("中でworker.listに#{server[:jvmroute]}が指定されていること") do
        it { should contain("^worker.list=.*#{server[:jvmroute]}.*$") }
      end

      describe ("中でworker.#{server[:jvmroute]}.referenceにworker.templateが指定されていること") do
        it { should contain("^worker.#{server[:jvmroute]}.reference=worker.template$") }
      end

      describe ("中でworker.#{server[:jvmroute]}.hostに#{server[:host]}が指定されていること"), :if => server[:host] != nil do
        it { should contain("^worker.#{server[:jvmroute]}.host=#{server[:host]}$") }
      end

      describe ("中でworker.#{server[:jvmroute]}.lbfactorに#{server[:weight]}が指定されていること"), :if => server[:weight] != nil do
        it { should contain("^worker.#{server[:jvmroute]}.lbfactor=#{server[:weight]}$") }
      end

      if linked_ap_servers.length > 1
        describe ("中でworker.loadbalancer.balance_workersに#{server[:jvmroute]}を指定していること") do
          it { should contain("^worker.loadbalancer.balance_workers=.*#{ server[:jvmroute] }.*$") }
        end

        describe ("中でworker.listにloadbalancerを指定していること") do
          it { should contain("^worker.list=.*loadbalancer.*$") }
        end

        describe ("中でworker.loadbalancer.typeにlbを指定していること") do
          it { should contain("^worker.loadbalancer.type=lb$") }
        end

        sticky_session = mod_jk[:loadbalance][:sticky_session] rescue nil
        describe ("中でworker.loadbalancer.sticky_sessionにtrueを指定していること"), :if => sticky_session == true do
          it { should contain("^worker.loadbalancer.sticky_session=true$") }
        end

        describe ("中でworker.loadbalancer.sticky_sessionにfalseを指定していること"), :if => sticky_session == false do
          it { should contain("^worker.loadbalancer.sticky_session=false$") }
        end
      end
    end
  end

  describe file('/etc/httpd/conf.d/uriworkermap.properties') do
    jkmounts = Array(property[:apache][:mod_jk][:jkmount]) rescue []

    jkmounts.each do |jkmount|
      uri = jkmount[:uri]
      workers = jkmount[:workers]
      positive = jkmount[:positive]

      should_failed = [uri, workers, positive].any? &:nil?
      raise "テストに必要なパラメータapache.mod_jk.jkmount.{uri,workers,positive}が不足しています" if should_failed

      describe ("中でURI#{uri}に対しワーカ#{workers}が指定されていること"), :if => positive == true do
        it { should contain("^#{uri}=#{workers}$") }
      end

      describe ("中でURI#{uri}に対しワーカ#{workers}が否定で指定されていること"), :if => positive == false do
        it { should contain("^!#{uri}=#{workers}$") }
      end
    end
  end
end
