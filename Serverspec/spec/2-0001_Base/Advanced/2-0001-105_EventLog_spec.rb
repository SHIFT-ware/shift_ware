describe ("105_EventLog")do
  describe ("イベントログ[アプリケーション]") do
    begin
      application = property[:ADVANCED][:eventlog][:application]
    rescue
      application = nil
    end

    next if application == nil

    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application') do
      describe ("のログのパスが #{ application[:filepath] } であること"), :if => application[:filepath] != nil do
        it { should have_property_value('File', :type_expandstring, "#{ application[:filepath] }") }
      end

      case application[:type]
      when "overwrite"
        context ("のローテート設定が 必要に応じてイベントを上書きする（最も古いイベントから）であること ") do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0") }
        end
      when "archive"
        context ("のローテート設定が イベントを上書きしないでログをアーカイブする であること") do
          it { should have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      when "none"
        context ("のローテート設定が イベントを上書きしない（ログは手動で消去）") do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      end
    end

    describe ("のサイズが #{ application[:maxsize] }KB であること"), :if => application[:maxsize] != nil do
      describe command('Write-Host -NoNewLine (((Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Application").MaxSize/1KB).ToString())') do
        its(:stdout) { should eq "#{ application[:maxsize] }" }
      end
    end
  end

  describe ("イベントログ[セキュリティ]") do
    begin
      security = property[:ADVANCED][:eventlog][:security]
    rescue
      security = nil
    end

    next if security == nil

    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Security') do
      describe ("のログのパスが #{ security[:filepath] } であること"), :if => security[:filepath] != nil do
        it { should have_property_value('File', :type_expandstring, "#{ security[:filepath] }") }
      end

      case security[:type]
      when "overwrite"
        context ("のローテート設定が 必要に応じてイベントを上書きする（最も古いイベントから）であること "), :if => security[:type] == "overwrite" do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0") }
        end
      when "archive"
        context ("のローテート設定が イベントを上書きしないでログをアーカイブする であること"), :if => security[:type] == "archive" do
          it { should have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      when "none"
        context ("のローテート設定が イベントを上書きしない（ログは手動で消去）"), :if => security[:type] == "none" do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      end
    end

    describe ("のサイズが #{ security[:maxsize] }KB であること"), :if => security[:maxsize] != nil do
      describe command('Write-Host -NoNewLine (((Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Security").MaxSize/1KB).ToString())') do
        its(:stdout) { should eq "#{ security[:maxsize] }" }
      end
    end
  end

  describe ("イベントログ[システム]") do
    begin
      system = property[:ADVANCED][:eventlog][:system]
    rescue
      system = nil
    end

    next if system == nil

    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\System') do
      describe ("のログのパスが #{ system[:filepath] } であること"), :if => system[:filepath] != nil do
        it { should have_property_value('File', :type_expandstring, "#{ system[:filepath] }") }
      end

      case system[:type]
      when "overwrite"
        context ("のローテート設定が 必要に応じてイベントを上書きする（最も古いイベントから）であること "), :if => system[:type] == "overwrite" do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0") }
        end
      when "archive"
        context ("のローテート設定が イベントを上書きしないでログをアーカイブする であること"), :if => system[:type] == "archive" do
          it { should have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      when "none"
        context ("のローテート設定が イベントを上書きしない（ログは手動で消去）"), :if => system[:type] == "none" do
          it { should_not have_property_value('AutoBackupLogFiles', :type_dword, "1") }
          it { should have_property_value('Retention', :type_dword, "0xffffffff") }
        end
      end
    end

    describe ("のサイズが #{ system[:maxsize] }KB であること"), :if => system[:maxsize] != nil do
      describe command('Write-Host -NoNewLine (((Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\System").MaxSize/1KB).ToString())') do
        its(:stdout) { should eq "#{ system[:maxsize] }" }
      end
    end
  end
end


