

describe ("094-Logrotate") do
  describe file("/etc/logrotate.conf") do
    begin
      basic_option = property[:ADVANCED][:logrotate_basic_option]
    rescue NoMethodError
      basic_option = nil
    end

    next if basic_option == nil

    describe ("基本ローテート周期が#{ basic_option[:cycle] }であること"), :if => basic_option[:cycle] != nil do
      its(:content) { should match /^#{ basic_option[:cycle] }\s*$/ }
    end

    describe ("基本ローテート数が#{ basic_option[:rotate_num] }であること"), :if => basic_option[:rotate_num] != nil do
      its(:content) { should match /^rotate\s+#{ basic_option[:rotate_num] }\s*$/ }
    end

    describe ("基本ローテート時に新しいファイルを作る、が#{ basic_option[:create] }であること"), :if => basic_option[:create] == TRUE do
      its(:content) { should match /^create\s*$/ }
    end

    describe ("基本ログファイルの末尾に数字ではなくタイムスタンプを付けること"), :if => basic_option[:add_date] == TRUE do
      its(:content) { should match /^dateext\s*$/ }
    end

    describe ("基本ログローテート時に圧縮すること"), :if=> basic_option[:compress] == TRUE do
      its(:content) { should match /^compress\s*$/ }
    end
  end

  begin
    logrotate_files = property[:ADVANCED][:logrotate_files]
  rescue NoMethodError
    logrotate_files = nil
  end

  next if logrotate_files == nil

  logrotate_files.each do |logrotate_file|
    describe ("#{ logrotate_file[:path] }が存在すること") do
      describe file(logrotate_file[:path]) do
        it { should exist }
      end
    end
  end
end
