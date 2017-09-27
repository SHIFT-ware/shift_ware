describe ("1-0103_Tomcat(server.xml)") do
  connector = property[:Tomcat][:connector] rescue nil
  engine = property[:Tomcat][:engine] rescue nil
  cluster = property[:Tomcat][:cluster] rescue nil

  next if connector == nil && engine == nil && cluster == nil

  install_dir = property[:Tomcat][:install_dir] rescue nil
  case install_dir
  when nil
    raise "server.xmlのテストにはパラメータTomcat.install_dirの設定が必要です"
  else
    describe file("#{ install_dir }/conf/server.xml") do
      content = Specinfra.backend.run_command("cat #{ install_dir }/conf/server.xml").stdout
      content.gsub!(/<!--.*?-->/m, '')
      content.gsub!(/\s*\n+/, "\n")

      describe ("Connectorタグ") do
        connector = property[:Tomcat][:connector] rescue nil
        
        next if connector == nil

        connectors = content.scan(/<Connector.*?\/>/m)
        describe ("HTTPコネクタ") do
          connector_http = ""
          connectors.each do |connector|
            if connector.match(/protocol="HTTP\/.*"/) != nil
              connector_http = connector
            end
          end 

          http = property[:Tomcat][:connector][:http] rescue nil

          next if http == nil

          port = http[:port] rescue nil
          describe ("のportが#{ port }であること"), :if => port != nil do
            it { connector_http.should match /(^|\s)port="#{ port }"/ }
          end

          protocol = http[:protocol] rescue nil
          describe ("のprotocolが#{ protocol }であること"), :if => protocol != nil do
            it { connector_http.should match /(^|\s)protocol="#{ Regexp.escape(protocol) }"/ }
          end

          redirectPort = http[:redirectPort] rescue nil
          describe ("のredirectPortが#{ redirectPort }であること"), :if => redirectPort != nil do
            it { connector_http.should match /(^|\s)redirectPort="#{ redirectPort }"/ }
          end

          acceptCount = http[:acceptCount] rescue nil
          describe ("のacceptCountが#{ acceptCount }であること"), :if => acceptCount != nil do
            it { connector_http.should match /(^|\s)acceptCount="#{ acceptCount }"/ }
          end

          connectionTimeout = http[:connectionTimeout] rescue nil
          describe ("のconnectionTimeoutが#{ connectionTimeout }であること"), :if => connectionTimeout != nil do
            it { connector_http.should match /(^|\s)connectionTimeout="#{ connectionTimeout }"/ }
          end

          keepAliveTimeout = http[:keepAliveTimeout] rescue nil
          describe ("のkeepAliveTimeoutが#{ keepAliveTimeout }であること"), :if => keepAliveTimeout != nil do
            it { connector_http.should match /(^|\s)keepAliveTimeout="#{ keepAliveTimeout }"/ }
          end

          maxConnections = http[:maxConnections] rescue nil
          describe ("のmaxConnectionsが#{ maxConnections }であること"), :if => maxConnections != nil do
            it { connector_http.should match /(^|\s)maxConnections="#{ maxConnections }"/ }
          end

          maxKeepAliveRequests = http[:maxKeepAliveRequests] rescue nil
          describe ("のmaxKeepAliveRequestsが#{ maxKeepAliveRequests }であること"), :if => maxKeepAliveRequests != nil do
            it { connector_http.should match /(^|\s)maxKeepAliveRequests="#{ maxKeepAliveRequests }"/ }
          end

          maxThreads = http[:maxThreads] rescue nil
          describe ("のmaxThreadsが#{ maxThreads }であること"), :if => maxThreads != nil do
            it { connector_http.should match /(^|\s)maxThreads="#{ maxThreads }"/ }
          end

          minSpareThreads = http[:minSpareThreads] rescue nil
          describe ("のminSpareThreadsが#{ minSpareThreads }であること"), :if => minSpareThreads != nil do
            it { connector_http.should match /(^|\s)minSpareThreads="#{ minSpareThreads }"/ }
          end
        end
  
        describe ("AJPコネクタ") do
          connector_ajp = ""
          connectors.each do |connector|
            if connector.match(/protocol="AJP\/.*"/) != nil
              connector_ajp = connector
            end
          end 

          ajp = property[:Tomcat][:connector][:ajp] rescue nil

          next if ajp == nil

          port = ajp[:port] rescue nil
          describe ("のportが#{ port }であること"), :if => port != nil do
            it { connector_ajp.should match /(^|\s)port="#{ port }"/ }
          end

          protocol = ajp[:protocol] rescue nil
          describe ("のprotocolが#{ protocol }であること"), :if => protocol != nil do
            it { connector_ajp.should match /(^|\s)protocol="#{ Regexp.escape(protocol) }"/ }
          end

          redirectPort = ajp[:redirectPort] rescue nil
          describe ("のredirectPortが#{ redirectPort }であること"), :if => redirectPort != nil do
            it { connector_ajp.should match /(^|\s)redirectPort="#{ redirectPort }"/ }
          end

          acceptCount = ajp[:acceptCount] rescue nil
          describe ("のacceptCountが#{ acceptCount }であること"), :if => acceptCount != nil do
            it { connector_ajp.should match /(^|\s)acceptCount="#{ acceptCount }"/ }
          end

          connectionTimeout = ajp[:connectionTimeout] rescue nil
          describe ("のconnectionTimeoutが#{ connectionTimeout }であること"), :if => connectionTimeout != nil do
            it { connector_ajp.should match /(^|\s)connectionTimeout="#{ connectionTimeout }"/ }
          end

          keepAliveTimeout = ajp[:keepAliveTimeout] rescue nil
          describe ("のkeepAliveTimeoutが#{ keepAliveTimeout }であること"), :if => keepAliveTimeout != nil do
            it { connector_ajp.should match /(^|\s)keepAliveTimeout="#{ keepAliveTimeout }"/ }
          end

          maxConnections = ajp[:maxConnections] rescue nil
          describe ("のmaxConnectionsが#{ maxConnections }であること"), :if => maxConnections != nil do
            it { connector_ajp.should match /(^|\s)maxConnections="#{ maxConnections }"/ }
          end

          maxThreads = ajp[:maxThreads] rescue nil
          describe ("のmaxThreadsが#{ maxThreads }であること"), :if => maxThreads != nil do
            it { connector_ajp.should match /(^|\s)maxThreads="#{ maxThreads }"/ }
          end

          minSpareThreads = ajp[:minSpareThreads] rescue nil
          describe ("のminSpareThreadsが#{ minSpareThreads }であること"), :if => minSpareThreads != nil do
            it { connector_ajp.should match /(^|\s)minSpareThreads="#{ minSpareThreads }"/ }
          end

          enableLookups = ajp[:enableLookups] rescue nil
          describe ("のenableLookupsが#{ enableLookups }であること"), :if => enableLookups != nil do
            it { connector_ajp.should match /(^|\s)enableLookups="#{ enableLookups }"/ }
          end
        end
      end

      describe ("Engineタグ") do
        engine = property[:Tomcat][:engine]

        next if engine == nil

        engine = ""
        if content.match(/<Engine.*?>/m) != nil
          engine = content.match(/<Engine.*?>/m)[0]
        end

        defaultHost = engine[:defaultHost] rescue nil
        describe ("のdefaultHostが#{ defaultHost }であること"), :if => defaultHost != nil do
          it { engine.should match /(^|\s)defaultHost="#{ defaultHost }"/ }
        end

        jvmRoute = engine[:jvmRoute] rescue nil
        describe ("のjvmRouteが#{ jvmRoute }であること"), :if => jvmRoute != nil do
          it { engine.should match /(^|\s)jvmRoute="#{ jvmRoute }"/ }
        end
      end
  
      describe ("Clusterタグ") do
        cluster = property[:Tomcat][:cluster] rescue nil

        next if cluster == nil

        cluster_tag = ""
        if content.match(/<Cluster.*?>.*<\/Cluster>/m) != nil
          cluster_tag = content.match(/<Cluster.*?>.*<\/Cluster>/m)[0]
        end

        cluster_attr = ""
        if cluster_tag.match(/<Cluster.*?>/m) != nil
          cluster_attr = cluster_tag.match(/<Cluster.*?>/m)[0]
        end
 
        channelSendOptions = cluster[:channelSendOptions] rescue nil
        describe ("のchannelSendOptionsが#{ channelSendOptions }であること"), :if => channelSendOptions != nil do
          it { cluster_attr.should match /(^|\s)channelSendOptions="#{ channelSendOptions }"/ } 
        end

        channelStartOptions = cluster[:channelStartOptions] rescue nil
        describe ("のchannelStartOptionsが#{ channelStartOptions }であること"), :if => channelStartOptions != nil do
          it { cluster_attr.should match /(^|\s)channelStartOptions="#{ channelStartOptions }"/ } 
        end

        describe ("Managerタグ") do
          manager = cluster[:manager] rescue nil

          next if manager == nil

          manager_tag = ""
          if cluster_tag.match(/<Manager.*?\/>/m) != nil
            manager_tag = cluster_tag.match(/<Manager.*?\/>/m)[0]
          end
        
          type = manager[:type] rescue nil  
          describe ("のclassNameが#{ type }であること"), :if => type != nil do
            it { manager_tag.should match /(^|\s)className="org.apache.catalina.ha.session.#{ type }"/ }
          end

          notifyListenersOnReplication = manager[:notifyListenersOnReplication] rescue nil
          describe ("のnotifyListenersOnReplicationが#{ notifyListenersOnReplication }であること"), :if => notifyListenersOnReplication != nil do
            it { manager_tag.should match /(^|\s)notifyListenersOnReplication="#{ notifyListenersOnReplication }"/ }
          end

          mapSendOptions = manager[:mapSendOptions] rescue nil
          describe ("のmapSendOptionsが#{ mapSendOptions }であること"), :if => mapSendOptions != nil do
            it { manager_tag.should match /(^|\s)mapSendOptions="#{ mapSendOptions }"/ }
          end
        end
  
        describe ("Receiverタグ") do
          receiver = cluster[:receiver] rescue nil

          next if receiver == nil

          receiver_tag = ""
          if cluster_tag.match(/<Receiver.*?\/>/m) != nil
            receiver_tag = cluster_tag.match(/<Receiver.*?\/>/m)[0]
          end

          address = receiver[:address] rescue nil
          describe ("のaddressが#{ address }であること"), :if => address != nil do
            it { receiver_tag.should match /(^|\s)address="#{ address }"/ }
          end

          port = receiver[:port] rescue nil
          describe ("のportが#{ port }であること"), :if => port != nil do
            it { receiver_tag.should match /(^|\s)port="#{ port }"/ }
          end

          selectorTimeout = receiver[:selectorTimeout] rescue nil
          describe ("のselectorTimeoutが#{ selectorTimeout }であること"), :if => selectorTimeout != nil do
            it { receiver_tag.should match /(^|\s)selectorTimeout="#{ selectorTimeout }"/ }
          end

          maxThreads = receiver[:maxThreads] rescue nil
          describe ("のmaxThreadsが#{ maxThreads }であること"), :if => maxThreads != nil do
            it { receiver_tag.should match /(^|\s)maxThreads="#{ maxThreads }"/ }
          end
        end

        enable_multicast = cluster[:member][:enable_multicast]
        if enable_multicast == true
          describe ("Membershipタグ") do
            members = Array(cluster[:member][:members]) rescue []
            membership_tags = cluster_tag.scan(/<Membership.*?\/>/m)

            members.each do |member|
              address = member[:address] rescue nil
              if address != nil
                membership_tag = ""
                membership_tags.each do |pickup_tag|
                  if pickup_tag.match(/address="#{ address }"/) != nil
                    membership_tag = pickup_tag
                  end
                end

                describe ("のaddressが#{ address }であること") do
                  it { membership_tag.should match /(^|\s)address="#{ address }"/ }
                end

                port = member[:port] rescue nil
                describe ("のportが#{ port }であること"), :if => port != nil do
                  it { membership_tag.should match /(^|\s)port="#{ port }"/ }
                end

                frequency = member[:frequency] rescue nil
                describe ("のfrequencyが#{ frequency }であること"), :if => frequency != nil do
                  it { membership_tag.should match /(^|\s)frequency="#{ frequency }"/ }
                end

                dropTime = member[:dropTime] rescue nil
                describe ("のdropTimeが#{ dropTime }であること"), :if => dropTime != nil do
                  it { membership_tag.should match /(^|\s)dropTime="#{ dropTime }"/ }
                end
              else
                raise "テストに必要なパラメータTomcat.cluster.member.members.x.addressが不足しています"
              end
            end
          end
        else
          describe ("Memberタグ") do
            members = Array(cluster[member][:members]) rescue []
            member_tags = cluster_tag.scan(/<Member.*?\/>/m)

            members.each do |member|
              host = member[:host] rescue nil
              if host != nil
                member_tag = ""
                member_tags.each do |pickup_tag|
                  if pickup_tag.match(/host="#{ host }"/) != nil
                    member_tag = pickup_tag
                  end
                end
 
                describe ("のhostが#{ host }であること"), :if => host != nil do
                  it { member.should match /(^|\s)host="#{ host }"/ }
                end

                port = member[:port] rescue nil
                describe ("のportが#{ port }であること"), :if => port != nil do
                  it { member.should match /(^|\s)port="#{ port }"/ }
                end

                domain = member[:domain] rescue nil
                describe ("のdomainが#{ domain }であること"), :if => domain != nil do
                  it { member.should match /(^|\s)domain="#{ domain }"/ }
                end

                uniqueId = member[:uniqueId] rescue nil
                describe ("のuniqueIdが#{ uniqueId }であること"), :if => uniqueId != nil do
                  it { member.should match /(^|\s)uniqueId="#{ uniqueId }"/ }
                end
              else
                raise "テストに必要なパラメータTomcat.cluster.member.members.x.hostが不足しています"
              end
            end
          end
        end
      end
    end
  end
end
