describe ("025_RecoverOs")do

  begin
    recover_os = property[:BASE][:OSCORE][:recover_os]
  rescue
    recover_os = nil
  end

  next if recover_os == nil

  describe ("起動と回復") do

    describe ("の 規定のオペレーティング システム が #{recover_os[:default_os_version]} であること"), :if => recover_os[:default_os_version] != nil do
      describe command("Write-Host (wmic recoveros get Name)") do
        its(:stdout) { should match /(\R|\s)#{recover_os[:default_os_version]}(\s|\|)/ }
      end
    end


    describe ("の オペレーティング システムの一覧を表示する時間 が #{recover_os[:display_os_list_time]}秒 であること"), :if => recover_os[:display_os_list_time] != nil do
      describe command("Bcdedit /enum BOOTMGR") do
        its(:stdout) { should match /(\A|\R)timeout\s+#{recover_os[:display_os_list_time]}(\s|\R|\Z)/ }
      end
    end

    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl') do

      context ("の システム ログにイベントを書き込む 設定が 有効 であること"), :if => recover_os[:write_eventlog] == true do
        it { should have_property_value('LogEvent', :type_dword, "1") }
      end
      context ("の システム ログにイベントを書き込む 設定が 無効 であること"), :if => recover_os[:write_eventlog] == false do
        it { should have_property_value('LogEvent', :type_dword, "0") }
      end

      context ("の 自動的に再起動する 設定が 有効 であること"), :if => recover_os[:auto_reboot] == true do
        it { should have_property_value('AutoReboot', :type_dword, "1") }
      end
      context ("の 自動的に再起動する 設定が 無効 であること"), :if => recover_os[:auto_reboot] == false do
        it { should have_property_value('AutoReboot', :type_dword, "0") }
      end

      describe ("の メモリダンプ") do
        dumpfile = recover_os[:dumpfile]
        next if dumpfile == nil

        case dumpfile[:type]
        when "none"
          context ("の種類が なし であること") do
            it { should have_property_value('CrashDumpEnabled', :type_dword, "0") }
          end
        when "minimum"
          context ("の種類が 最小メモリ ダンプ (256 KB) であること") do
            it { should have_property_value('CrashDumpEnabled', :type_dword, "1") }
          end
        when "kernel"
          context ("の種類が カーネル メモリ ダンプ であること") do
            it { should have_property_value('CrashDumpEnabled', :type_dword, "2") }
          end
        when "full"
          context ("の種類が 完全メモリ ダンプ であること") do
            it { should have_property_value('CrashDumpEnabled', :type_dword, "3") }
          end
        when "auto"
          context ("の種類が 自動メモリ ダンプ であること") do
            it { should have_property_value('CrashDumpEnabled', :type_dword, "7") }
          end
        end

        describe ("ファイルパス が #{dumpfile[:path]} であること"), :if => dumpfile[:path] != nil do
          it { should have_property_value('DumpFile', :type_expandstring, "#{dumpfile[:path]}") }
        end

        context ("の 既存のファイルに上書きする 設定が 有効 であること"), :if => dumpfile[:overwrite] == true do
          it { should have_property_value('Overwrite', :type_dword, "1") }
        end
        context ("の 既存のファイルに上書きする 設定が 無効 であること"), :if => dumpfile[:overwrite] == false do
          it { should have_property_value('Overwrite', :type_dword, "0") }
        end
      end
    end
  end
end
