describe ("1-0103_Tomcat(setenv.sh)") do
  if property[:Tomcat][:envs] != nil || property[:Tomcat][:catalina_opts] != nil
    install_dir = property[:Tomcat][:install_dir] rescue nil
    case install_dir
    when nil
      raise "setenv.shのテストにはパラメータTomcat.install_dirの設定が必要です"
    else
      describe file("#{ install_dir }/bin/setenv.sh") do
        catalina_home = property[:Tomcat][:envs][:catalina_home] rescue nil
        describe ("にCATALINA_HOMEが#{ catalina_home }で記載されていること"), :if => catalina_home != nil do
          its(:content) { should match /^CATALINA_HOME=("|)#{ catalina_home }("|)$/ }    
        end

        catalina_base = property[:Tomcat][:envs][:catalina_base] rescue nil
        describe ("にCATALINA_BASEが#{ catalina_base }で記載されていること"), :if => catalina_base != nil do
          its(:content) { should match /^CATALINA_BASE=("|)#{ catalina_base }("|)$/ }    
        end

        catalina_out = property[:Tomcat][:envs][:catalina_out] rescue nil
        describe ("にCATALINA_OUTが#{ catalina_out }で記載されていること"), :if => catalina_out != nil do
          its(:content) { should match /^CATALINA_OUT=("|)#{ catalina_out }("|)$/ }    
        end

        java_home = property[:Tomcat][:envs][:java_home] rescue nil
        describe ("にJAVA_HOMEが#{ java_home }で記載されていること"), :if => java_home != nil do
          its(:content) { should match /^JAVA_HOME=("|)#{ java_home }("|)$/ }    
        end
        
        server = property[:Tomcat][:catalina_opts][:server] rescue nil
        describe ("中でCATALINA_OPTSの-serverが#{ server }になっていること"), :if => server != nil  do
          case server
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-server("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-server("|)$/ }
          end
        end

        xms = property[:Tomcat][:catalina_opts][:Xms] rescue nil
        describe ("中でCATALINA_OPTSのXmsの値が#{ xms }mであること"), :if => xms != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-Xms#{ xms }m("|)$/ }
        end

        xmx = property[:Tomcat][:catalina_opts][:Xmx] rescue nil
        describe ("中でCATALINA_OPTSのXmxの値が#{ xmx }mであること"), :if => xmx != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-Xmx#{ xmx }m("|)$/ }
        end

        maxMetaspaceSize = property[:Tomcat][:catalina_opts][:MaxMetaspaceSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxMetaspaceSizeの値が#{ maxMetaspaceSize }mであること"), :if => maxMetaspaceSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:MaxMetaspaceSize=#{ maxMetaspaceSize }m("|)$/ }
        end

        maxPermSize = property[:Tomcat][:catalina_opts][:MaxPermSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxPermSizeの値が#{ maxPermSize }mであること"), :if => maxPermSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:MaxPermSize=#{ maxPermSize }m("|)$/ }
        end

        permSize = property[:Tomcat][:catalina_opts][:PermSize] rescue nil
        describe ("中でCATALINA_OPTSのPermSizeの値が#{ permSize }mであること"), :if => permSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:PermSize=#{ permSize }m("|)$/ }
        end

        xss = property[:Tomcat][:catalina_opts][:Xss] rescue nil
        describe ("中でCATALINA_OPTSのXssの値が#{ xss }kであること"), :if => xss != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-Xss#{ xss }k("|)$/ }
        end

        newSize = property[:Tomcat][:catalina_opts][:NewSize] rescue nil
        describe ("中でCATALINA_OPTSのNewSizeの値が#{ newSize }kであること"), :if => newSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:NewSize=#{ newSize }m("|)$/ }
        end

        maxNewSize = property[:Tomcat][:catalina_opts][:MaxNewSize] rescue nil
        describe ("中でCATALINA_OPTSのMaxNewSizeの値が#{ maxNewSize }kであること"), :if => maxNewSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:MaxNewSize=#{ maxNewSize }m("|)$/ }
        end

        targetSurvivorRatio = property[:Tomcat][:catalina_opts][:TargetSurvivorRatio] rescue nil
        describe ("中でCATALINA_OPTSのTargetSurvivorRatioの値が#{ targetSurvivorRatio }であること"), :if => targetSurvivorRatio != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:TargetSurvivorRatio=#{ targetSurvivorRatio }("|)$/ }
        end

        metaspaceSize = property[:Tomcat][:catalina_opts][:MetaspaceSize] rescue nil
        describe ("中でCATALINA_OPTSのMetaspaceSizeの値が#{ metaspaceSize }mであること"), :if => metaspaceSize != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:MetaspaceSize=#{ metaspaceSize }m("|)$/ }
        end

        initialTenuringThreshold = property[:Tomcat][:catalina_opts][:InitialTenuringThreshold] rescue nil
        describe ("中でCATALINA_OPTSのInitialTenuringThresholdの値が#{ initialTenuringThreshold }であること"), :if => initialTenuringThreshold != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:InitialTenuringThreshold=#{ initialTenuringThreshold }("|)$/ }
        end

        maxTenuringThreshold = property[:Tomcat][:catalina_opts][:MaxTenuringThreshold] rescue nil
        describe ("中でCATALINA_OPTSのMaxTenuringThresholdの値が#{ maxTenuringThreshold }であること"), :if => maxTenuringThreshold != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:MaxTenuringThreshold=#{ maxTenuringThreshold }("|)$/ }
        end

        survivorRatio = property[:Tomcat][:catalina_opts][:SurvivorRatio] rescue nil
        describe ("中でCATALINA_OPTSのSurvivorRatioの値が#{ survivorRatio }であること"), :if => survivorRatio != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:SurvivorRatio=#{ survivorRatio }("|)$/ }
        end

        useConcMarkSweepGC = property[:Tomcat][:catalina_opts][:UseConcMarkSweepGC] rescue nil
        describe ("中でCATALINA_OPTSのUseConcMarkSweepGCの値が#{ useConcMarkSweepGC }であること"), :if => useConcMarkSweepGC != nil do
          case useConcMarkSweepGC
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseConcMarkSweepGC("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseConcMarkSweepGC("|)$/ }
          end
        end

        useParNewGC = property[:Tomcat][:catalina_opts][:UseParNewGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParNewGCの値が#{ useParNewGC }であること"), :if => useParNewGC != nil do
          case useParNewGC
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParNewGC("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParNewGC("|)$/ }
          end
        end

        cMSParallelRemarkEnabled = property[:Tomcat][:catalina_opts][:CMSParallelRemarkEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSParallelRemarkEnabledの値が#{ cMSParallelRemarkEnabled }であること"), :if => cMSParallelRemarkEnabled != nil do
          case cMSParallelRemarkEnabled
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSParallelRemarkEnabled("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSParallelRemarkEnabled("|)$/ }
          end
        end

        cMSConcurrentMTEnabled = property[:Tomcat][:catalina_opts][:CMSConcurrentMTEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSConcurrentMTEnabledの値が#{ cMSConcurrentMTEnabled }であること"), :if => cMSConcurrentMTEnabled != nil do
          case cMSConcurrentMTEnabled
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSConcurrentMTEnabled("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSConcurrentMTEnabled("|)$/ }
          end
        end

        cMSIncrementalMode = property[:Tomcat][:catalina_opts][:CMSIncrementalMode] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalModeの値が#{ cMSIncrementalMode }であること"), :if => cMSIncrementalMode != nil do
          case cMSIncrementalMode
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSIncrementalMode("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSIncrementalMode("|)$/ }
          end
        end

        cMSIncrementalPacing = property[:Tomcat][:catalina_opts][:CMSIncrementalPacing] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalPacingの値が#{ cMSIncrementalPacing }であること"), :if => cMSIncrementalPacing != nil do
          case cMSIncrementalPacing
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSIncrementalPacing("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSIncrementalPacing("|)$/ }
          end
        end

        cMSIncrementalDutyCycleMin = property[:Tomcat][:catalina_opts][:CMSIncrementalDutyCycleMin] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalDutyCycleMinの値が#{ cMSIncrementalDutyCycleMin }であること"), :if => cMSIncrementalDutyCycleMin != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:CMSIncrementalDutyCycleMin=#{ cMSIncrementalDutyCycleMin }("|)$/ }
        end

        cMSIncrementalDutyCycle = property[:Tomcat][:catalina_opts][:CMSIncrementalDutyCycle] rescue nil
        describe ("中でCATALINA_OPTSのCMSIncrementalDutyCycleの値が#{ cMSIncrementalDutyCycle }であること"), :if => cMSIncrementalDutyCycle != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:CMSIncrementalDutyCycle=#{ cMSIncrementalDutyCycle }("|)$/ }
        end

        cMSClassUnloadingEnabled = property[:Tomcat][:catalina_opts][:CMSClassUnloadingEnabled] rescue nil
        describe ("中でCATALINA_OPTSのCMSClassUnloadingEnabledの値が#{ cMSClassUnloadingEnabled }であること"), :if => cMSClassUnloadingEnabled != nil do
          case cMSClassUnloadingEnabled
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSClassUnloadingEnabled("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+CMSClassUnloadingEnabled("|)$/ }
          end
        end

        cMSInitiatingOccupancyFraction = property[:Tomcat][:catalina_opts][:CMSInitiatingOccupancyFraction] rescue nil
        describe ("中でCATALINA_OPTSのCMSInitiatingOccupancyFractionの値が#{ cMSInitiatingOccupancyFraction }であること"), :if => cMSInitiatingOccupancyFraction != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:CMSInitiatingOccupancyFraction=#{ cMSInitiatingOccupancyFraction }("|)$/ }
        end

        useParallelGC = property[:Tomcat][:catalina_opts][:UseParallelGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParallelGCの値が#{ useParallelGC }であること"), :if => useParallelGC != nil do
          case useParallelGC
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParallelGC("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParallelGC("|)$/ }
          end
        end

        useParallelOldGC = property[:Tomcat][:catalina_opts][:UseParallelOldGC] rescue nil
        describe ("中でCATALINA_OPTSのUseParallelOldGCの値が#{ useParallelOldGC }であること"), :if => useParallelOldGC != nil do
          case useParallelOldGC
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParallelOldGC("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseParallelOldGC("|)$/ }
          end
        end

        useTLAB = property[:Tomcat][:catalina_opts][:UseTLAB] rescue nil
        describe ("中でCATALINA_OPTSのUseTLABの値が#{ useTLAB }であること"), :if => useTLAB != nil do
          case useTLAB
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseTLAB("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseTLAB("|)$/ }
          end
        end

        resizeTLAB = property[:Tomcat][:catalina_opts][:ResizeTLAB] rescue nil
        describe ("中でCATALINA_OPTSのResizeTLABの値が#{ resizeTLAB }であること"), :if => resizeTLAB != nil do
          case resizeTLAB
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+ResizeTLAB("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+ResizeTLAB("|)$/ }
          end
        end

        disableExplicitGC = property[:Tomcat][:catalina_opts][:DisableExplicitGC] rescue nil
        describe ("中でCATALINA_OPTSのDisableExplicitGCの値が#{ disableExplicitGC }であること"), :if => disableExplicitGC != nil do
          case disableExplicitGC
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+DisableExplicitGC("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+DisableExplicitGC("|)$/ }
          end
        end

        useCompressedOops = property[:Tomcat][:catalina_opts][:UseCompressedOops] rescue nil
        describe ("中でCATALINA_OPTSのUseCompressedOopsの値が#{ useCompressedOops }であること"), :if => useCompressedOops != nil do
          case useCompressedOops
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseCompressedOops("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseCompressedOops("|)$/ }
          end
        end

        useStringCache = property[:Tomcat][:catalina_opts][:UseStringCache] rescue nil
        describe ("中でCATALINA_OPTSのUseStringCacheの値が#{ useStringCache }であること"), :if => useStringCache != nil do
          case useStringCache
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseStringCache("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseStringCache("|)$/ }
          end
        end

        useAdaptiveGCBoundary = property[:Tomcat][:catalina_opts][:UseAdaptiveGCBoundary] rescue nil
        describe ("中でCATALINA_OPTSのUseAdaptiveGCBoundaryの値が#{ useAdaptiveGCBoundary }であること"), :if => useAdaptiveGCBoundary != nil do
          case useAdaptiveGCBoundary
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseAdaptiveGCBoundary("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseAdaptiveGCBoundary("|)$/ }
          end
        end

        useBiasedLocking = property[:Tomcat][:catalina_opts][:UseBiasedLocking] rescue nil
        describe ("中でCATALINA_OPTSのUseBiasedLockingの値が#{ useBiasedLocking }であること"), :if => useBiasedLocking != nil do
          case useBiasedLocking
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseBiasedLocking("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+UseBiasedLocking("|)$/ }
          end
        end

        heapDumpOnOutOfMemoryError = property[:Tomcat][:catalina_opts][:HeapDumpOnOutOfMemoryError] rescue nil
        describe ("中でCATALINA_OPTSのHeapDumpOnOutOfMemoryErrorの値が#{ heapDumpOnOutOfMemoryError }であること"), :if => heapDumpOnOutOfMemoryError != nil do
          case heapDumpOnOutOfMemoryError
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+HeapDumpOnOutOfMemoryError("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+HeapDumpOnOutOfMemoryError("|)$/ }
          end
        end

        optimizeStringConcat = property[:Tomcat][:catalina_opts][:OptimizeStringConcat] rescue nil
        describe ("中でCATALINA_OPTSのOptimizeStringConcatの値が#{ optimizeStringConcat }であること"), :if => optimizeStringConcat != nil do
          case optimizeStringConcat
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+OptimizeStringConcat("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+OptimizeStringConcat("|)$/ }
          end
        end

        xloggc = property[:Tomcat][:catalina_opts][:Xloggc] rescue nil
        describe ("中でCATALINA_OPTSのXloggc値が#{ xloggc }であること"), :if => xloggc != nil do
          its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-Xloggc:#{ Regexp.escape(xloggc) }("|)$/ }
        end

        printGCDetails = property[:Tomcat][:catalina_opts][:PrintGCDetails] rescue nil
        describe ("中でCATALINA_OPTSのPrintGCDetailsの値が#{ printGCDetails }であること"), :if => printGCDetails != nil do
          case printGCDetails
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+PrintGCDetails("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+PrintGCDetails("|)$/ }
          end
        end

        printGCDateStamps = property[:Tomcat][:catalina_opts][:PrintGCDateStamps] rescue nil
        describe ("中でCATALINA_OPTSのPrintGCDateStampsの値が#{ printGCDateStamps }であること"), :if => printGCDateStamps != nil do
          case printGCDateStamps
          when true
            its(:content) { should match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+PrintGCDateStamps("|)$/ }
          when false
            its(:content) { should_not match /^CATALINA_OPTS=("|)\$CATALINA_OPTS\s+-XX:\+PrintGCDateStamps("|)$/ }
          end
        end
      end
    end
  end
end
