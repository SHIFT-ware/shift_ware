describe ("002-Memory") do
  begin
    type = property[:BASE][:HW][:memory][:virtualmemory][:type]
  rescue
    type = nil
  end

  next if type == nil

  describe ("レジストリの仮想メモリ設定箇所の正常性チェック") do
    describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management') do
      it { should have_property('PagingFiles', :type_multistring) }
    end
  end

  describe ("仮想メモリ設定")do
    describe command('Write-Host -NoNewline ((Get-ItemProperty "registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management").PagingFiles)') do
      case type
      when "none"
        context ("が ページング ファイルなし であること") do
          its(:stdout) { should eq "" }
        end
      when "system"
        context ("が システム管理サイズ であること") do
          its(:stdout) { should eq "c:\\pagefile.sys 0 0" }
        end
      when "custom"
        context ("が カスタム サイズ であること") do
          its(:stdout) { should match /^c:\\pagefile.sys \d+ \d+$/ }
        end

        begin
          max_size = property[:BASE][:HW][:memory][:virtualmemory][:size][:min]
          min_size = property[:BASE][:HW][:memory][:virtualmemory][:size][:max]
        rescue
          next
        end

        describe ("が 初期サイズ: #{min_size}(MB) 最大サイズ: #{max_size}(MB) であること") do
          its(:stdout) { should eq "c:\\pagefile.sys #{min_size} #{max_size}" }
        end
      when "auto"
        context ("が すべてのドライブのページング ファイルのサイズを自動的に管理する であること") do
          its(:stdout) { should eq "?:\\pagefile.sys" }
        end
      end
    end
  end
end
