describe ("1-0103_Tomcat(process)") do
  describe ("tomcatプロセス") do
    describe command("ps -ef | grep java | grep -v grep") do
      state = property[:Tomcat][:state] rescue nil

      next if state == nil

      case state
      when "started"
        describe ("が稼働していること") do
          its(:stdout) { should_not eq "" }
        end

        catalina_home = property[:Tomcat][:envs][:catalina_home] rescue nil
        describe ("上でCATALINA_HOMEが#{ catalina_home }で指定されていること"), :if => catalina_home != nil do
          its(:stdout) { should match /\s-Dcatalina.home=#{ catalina_home }\s/ }
        end

        catalina_base = property[:Tomcat][:envs][:catalina_base] rescue nil
        describe ("上でCATALINA_BASEが#{ catalina_base }で指定されていること"), :if => catalina_base != nil do
          its(:stdout) { should match /\s-Dcatalina.base=#{ catalina_base }\s/ }
        end
  
        server = property[:Tomcat][:catalina_opts][:server] rescue nil
        describe ("中でCATALINA_OPTSの-serverが#{ server }になっていること"), :if => server != nil do
          if server == true
            its(:stdout) { should match /\s-server\s/ }
          else
            its(:stdout) { should_not match /\s-server\s/ }
          end
        end

        xms = property[:Tomcat][:catalina_opts][:Xms] rescue nil
        describe ("中でCATALINA_OPTSのXmsの値が#{ xms }mであること"), :if => xms != nil do
          its(:stdout) { should match /\s-Xms#{ xms }m\s/ }
        end

        xmx = property[:Tomcat][:catalina_opts][:Xmx] rescue nil
        describe ("中でCATALINA_OPTSのXmxの値が#{ xmx }mであること"), :if => xmx != nil do
          its(:stdout) { should match /\s-Xmx#{ xmx }m\s/ }
        end

        maxMetaspaceSize = property[:Tomcat][:catalina_opts][:MaxMetaspaceSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxMetaspaceSizeの値が#{ maxMetaspaceSize }mであること"), :if => maxMetaspaceSize != nil do
          its(:stdout) { should match /\s-XX:MaxMetaspaceSize=#{ maxMetaspaceSize }m\s/ }
        end

        maxPermSize = property[:Tomcat][:catalina_opts][:MaxPermSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxPermSizeの値が#{ maxPermSize }mであること"), :if => maxPermSize != nil do
          its(:stdout) { should match /\s-XX:MaxPermSize=#{ maxPermSize }m\s/ }
        end

        permSize = property[:Tomcat][:catalina_opts][:PermSize] rescue nil
        describe ("中でCATALINA_OPTSのPermSizeの値が#{ permSize }mであること"), :if => permSize != nil do
          its(:stdout) { should match /\s-XX:PermSize=#{ permSize }m\s/ }
        end

        xss = property[:Tomcat][:catalina_opts][:Xss] rescue nil
        describe ("中でCATALINA_OPTSのXssの値が#{ xss }kであること"), :if => xss != nil do
          its(:stdout) { should match /\s-Xss#{ xss }k\s/ }
        end

        newSize = property[:Tomcat][:catalina_opts][:NewSize] rescue nil
        describe ("中でCATALINA_OPTSのNewSizeの値が#{ newSize }kであること"), :if => newSize != nil do
          its(:stdout) { should match /\s-XX:NewSize=#{ newSize }m\s/ }
        end

        maxNewSize = property[:Tomcat][:catalina_opts][:MaxNewSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxNewSizeの値が#{ maxNewSize }kであること"), :if => maxNewSize != nil do
          its(:stdout) { should match /\s-XX:MaxNewSize=#{ maxNewSize }m\s/ }
        end

        targetSurvivorRatio = property[:Tomcat][:catalina_opts][:TargetSurvivorRatio] rescue nil
        describe ("中でCATALINA_OPTSのTargetSurvivorRatioの値が#{ targetSurvivorRatio }であること"), :if => targetSurvivorRatio != nil do
          its(:stdout) { should match /\s-XX:TargetSurvivorRatio=#{ targetSurvivorRatio }\s/ }
        end

        metaspaceSize = property[:Tomcat][:catalina_opts][:MetaspaceSize] rescue nil
        describe ("中でCATALINA_OPTSのMetaspaceSizeの値が#{ metaspaceSize }mであること"), :if => metaspaceSize != nil do
          its(:stdout) { should match /\s-XX:MetaspaceSize=#{ metaspaceSize }m\s/ }
        end

        initialTenuringThreshold = property[:Tomcat][:catalina_opts][:InitialTenuringThreshold] rescue nil
        describe ("中でCATALINA_OPTSのInitialTenuringThresholdの値が#{ initialTenuringThreshold }であること"), :if => initialTenuringThreshold != nil do
          its(:stdout) { should match /\s-XX:InitialTenuringThreshold=#{ initialTenuringThreshold }\s/ }
        end

        maxTenuringThreshold = property[:Tomcat][:catalina_opts][:MaxTenuringThreshold] rescue nil
        describe ("中でCATALINA_OPTSのMaxTenuringThresholdの値が#{ maxTenuringThreshold }であること"), :if => maxTenuringThreshold != nil do
          its(:stdout) { should match /\s-XX:MaxTenuringThreshold=#{ maxTenuringThreshold }\s/ }
        end

        survivorRatio = property[:Tomcat][:catalina_opts][:SurvivorRatio] rescue nil
        describe ("中でCATALINA_OPTSのSurvivorRatioの値が#{ survivorRatio }であること"), :if => survivorRatio != nil do
          its(:stdout) { should match /\s-XX:SurvivorRatio=#{ survivorRatio }\s/ }
        end

        useConcMarkSweepGC = property[:Tomcat][:catalina_opts][:UseConcMarkSweepGC] rescue nil
        describe ("中でCATALINA_OPTSのUseConcMarkSweepGCの値が#{ useConcMarkSweepGC }であること"), :if => useConcMarkSweepGC != nil do
          case useConcMarkSweepGC
          when true
            its(:stdout) { should match /\s-XX:\+UseConcMarkSweepGC\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseConcMarkSweepGC\s/ }
          end
        end

        useParNewGC = property[:Tomcat][:catalina_opts][:UseParNewGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParNewGCの値が#{ useParNewGC }であること"), :if => useParNewGC != nil do
          case useParNewGC
          when true
            its(:stdout) { should match /\s-XX:\+UseParNewGC\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseParNewGC\s/ }
          end
        end

        cMSParallelRemarkEnabled = property[:Tomcat][:catalina_opts][:CMSParallelRemarkEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSParallelRemarkEnabledの値が#{ cMSParallelRemarkEnabled }であること"), :if => cMSParallelRemarkEnabled != nil do
          case cMSParallelRemarkEnabled
          when true
            its(:stdout) { should match /\s-XX:\+CMSParallelRemarkEnabled\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+CMSParallelRemarkEnabled\s/ }
          end
        end

        cMSConcurrentMTEnabled = property[:Tomcat][:catalina_opts][:CMSConcurrentMTEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSConcurrentMTEnabledの値が#{ cMSConcurrentMTEnabled }であること"), :if => cMSConcurrentMTEnabled != nil do
          case cMSConcurrentMTEnabled
          when true
            its(:stdout) { should match /\s-XX:\+CMSConcurrentMTEnabled\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+CMSConcurrentMTEnabled\s/ }
          end
        end

        cMSIncrementalMode = property[:Tomcat][:catalina_opts][:CMSIncrementalMode] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalModeの値が#{ cMSIncrementalMode }であること"), :if => cMSIncrementalMode != nil do
          case cMSIncrementalMode
          when true
            its(:stdout) { should match /\s-XX:\+CMSIncrementalMode\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+CMSIncrementalMode\s/ }
          end
        end

        cMSIncrementalPacing = property[:Tomcat][:catalina_opts][:CMSIncrementalPacing] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalPacingの値が#{ cMSIncrementalPacing }であること"), :if => cMSIncrementalPacing != nil do
          case cMSIncrementalPacing
          when true
            its(:stdout) { should match /\s-XX:\+CMSIncrementalPacing\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+CMSIncrementalPacing\s/ }
          end
        end

        cMSIncrementalDutyCycleMin = property[:Tomcat][:catalina_opts][:CMSIncrementalDutyCycleMin] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalDutyCycleMinの値が#{ cMSIncrementalDutyCycleMin }であること"), :if => cMSIncrementalDutyCycleMin != nil do
          its(:stdout) { should match /\s-XX:CMSIncrementalDutyCycleMin=#{ cMSIncrementalDutyCycleMin }\s/ }
        end

        cMSIncrementalDutyCycle = property[:Tomcat][:catalina_opts][:CMSIncrementalDutyCycle] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalDutyCycleの値が#{ cMSIncrementalDutyCycle }であること"), :if => cMSIncrementalDutyCycle != nil do
          its(:stdout) { should match /\s-XX:CMSIncrementalDutyCycle=#{ cMSIncrementalDutyCycle }\s/ }
        end

        cMSClassUnloadingEnabled = property[:Tomcat][:catalina_opts][:CMSClassUnloadingEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSClassUnloadingEnabledの値が#{ cMSClassUnloadingEnabled }であること"), :if => cMSClassUnloadingEnabled != nil do
          case cMSClassUnloadingEnabled
          when true
            its(:stdout) { should match /\s-XX:\+CMSClassUnloadingEnabled\s/ }
          when false 
            its(:stdout) { should_not match /\s-XX:\+CMSClassUnloadingEnabled\s/ }
          end
        end

        cMSInitiatingOccupancyFraction = property[:Tomcat][:catalina_opts][:CMSInitiatingOccupancyFraction] rescue nil
        describe ("中でCATALINA_OPTSのCMSInitiatingOccupancyFractionの値が#{ cMSInitiatingOccupancyFraction }であること"), :if => cMSInitiatingOccupancyFraction != nil do
          its(:stdout) { should match /\s-XX:CMSInitiatingOccupancyFraction=#{ cMSInitiatingOccupancyFraction }\s/ }
        end

        useParallelGC = property[:Tomcat][:catalina_opts][:UseParallelGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParallelGCの値が#{ useParallelGC }であること"), :if => useParallelGC != nil do
          case useParallelGC
          when true
            its(:stdout) { should match /\s-XX:\+UseParallelGC\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseParallelGC\s/ }
          end
        end

        useParallelOldGC = property[:Tomcat][:catalina_opts][:UseParallelOldGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParallelOldGCの値が#{ useParallelOldGC }であること"), :if => useParallelOldGC != nil do
          case useParallelOldGC
          when true
            its(:stdout) { should match /\s-XX:\+UseParallelOldGC\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseParallelOldGC\s/ }
          end
        end

        useTLAB = property[:Tomcat][:catalina_opts][:UseTLAB] rescue nil
        describe ("中でCATALINA_OPTSのUseTLABの値が#{ useTLAB }であること"), :if => useTLAB != nil do
          case useTLAB
          when true
            its(:stdout) { should match /\s-XX:\+UseTLAB\s/ }
          when false
           its(:stdout) { should_not match /\s-XX:\+UseTLAB\s/ }
          end
        end

        resizeTLAB = property[:Tomcat][:catalina_opts][:ResizeTLAB] rescue nil
        describe ("中でCATALINA_OPTSのResizeTLABの値が#{ resizeTLAB }であること"), :if => resizeTLAB != nil do
          case resizeTLAB
          when true
            its(:stdout) { should match /\s-XX:\+ResizeTLAB\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+ResizeTLAB\s/ }
          end
        end

        disableExplicitGC = property[:Tomcat][:catalina_opts][:DisableExplicitGC] rescue nil
        describe ("中でCATALINA_OPTSのDisableExplicitGCの値が#{ disableExplicitGC }であること"), :if => disableExplicitGC != nil do
          case disableExplicitGC
          when true
            its(:stdout) { should match /\s-XX:\+DisableExplicitGC\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+DisableExplicitGC\s/ }
          end
        end

        useCompressedOops = property[:Tomcat][:catalina_opts][:UseCompressedOops] rescue nil
        describe ("中でCATALINA_OPTSのUseCompressedOopsの値が#{ useCompressedOops }であること"), :if => useCompressedOops != nil do
          case useCompressedOops
          when true
            its(:stdout) { should match /\s-XX:\+UseCompressedOops\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseCompressedOops\s/ }
          end
        end

        useStringCache = property[:Tomcat][:catalina_opts][:UseStringCache] rescue nil
        describe ("中でCATALINA_OPTSのUseStringCacheの値が#{ useStringCache }であること"), :if => useStringCache != nil do
          case useStringCache
          when true
            its(:stdout) { should match /\s-XX:\+UseStringCache\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseStringCache\s/ }
          end
        end

        useAdaptiveGCBoundary = property[:Tomcat][:catalina_opts][:UseAdaptiveGCBoundary] rescue nil
        describe ("中でCATALINA_OPTSのUseAdaptiveGCBoundaryの値が#{ useAdaptiveGCBoundary }であること"), :if => useAdaptiveGCBoundary != nil do
          case useAdaptiveGCBoundary
          when true
            its(:stdout) { should match /\s-XX:\+UseAdaptiveGCBoundary\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseAdaptiveGCBoundary\s/ }
          end
        end

        useBiasedLocking = property[:Tomcat][:catalina_opts][:UseBiasedLocking] rescue nil
        describe ("中でCATALINA_OPTSのUseBiasedLockingの値が#{ useBiasedLocking }であること"), :if => useBiasedLocking != nil do
          case useBiasedLocking
          when true
            its(:stdout) { should match /\s-XX:\+UseBiasedLocking\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+UseBiasedLocking\s/ }
          end
        end

        heapDumpOnOutOfMemoryError = property[:Tomcat][:catalina_opts][:HeapDumpOnOutOfMemoryError] rescue nil
        describe ("中でCATALINA_OPTSのHeapDumpOnOutOfMemoryErrorの値が#{ heapDumpOnOutOfMemoryError }であること"), :if => heapDumpOnOutOfMemoryError != nil do
          case heapDumpOnOutOfMemoryError
          when true
            its(:stdout) { should match /\s-XX:\+HeapDumpOnOutOfMemoryError\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+HeapDumpOnOutOfMemoryError\s/ }
          end
        end

        optimizeStringConcat = property[:Tomcat][:catalina_opts][:OptimizeStringConcat] rescue nil
        describe ("中でCATALINA_OPTSのOptimizeStringConcatの値が#{ optimizeStringConcat }であること"), :if => optimizeStringConcat != nil do
          case optimizeStringConcat
          when true
            its(:stdout) { should match /\s-XX:\+OptimizeStringConcat\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+OptimizeStringConcat\s/ }
          end
        end

        xloggc = property[:Tomcat][:catalina_opts][:Xloggc] rescue nil
        describe ("中でCATALINA_OPTSのXloggc値が#{ xloggc }であること"), :if => xloggc != nil do
          its(:stdout) { should match /\s-Xloggc:#{ Regexp.escape(xloggc) }\s/ }
        end

        printGCDetails = property[:Tomcat][:catalina_opts][:PrintGCDetails] rescue nil
        describe ("中でCATALINA_OPTSのPrintGCDetailsの値が#{ printGCDetails }であること"), :if => printGCDetails != nil do
          case printGCDetails
          when true
            its(:stdout) { should match /\s-XX:\+PrintGCDetails\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+PrintGCDetails\s/ }
          end
        end

        printGCDateStamps = property[:Tomcat][:catalina_opts][:PrintGCDateStamps] rescue nil
        describe ("中でCATALINA_OPTSのPrintGCDateStampsの値が#{ printGCDateStamps }であること"), :if => printGCDateStamps != nil do
          case printGCDateStamps
          when true
            its(:stdout) { should match /\s-XX:\+PrintGCDateStamps\s/ }
          when false
            its(:stdout) { should_not match /\s-XX:\+PrintGCDateStamps\s/ }
          end
        end
      when "stopped"
        describe ("が稼働していないこと") do
          its(:stdout) { should eq "" }
        end
      else
        raise "Tomcat.stateの値が不正です"
      end
    end
  end
end
