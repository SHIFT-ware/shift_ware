describe ("097-NTP_Server") do
  begin
    timeservers = property[:ADVANCED][:timeserver]
  rescue NoMethodError
    timeservers = nil
  end

  next if timeservers == nil

  timeservers.each do |timeserver|
    describe file("/etc/ntp.conf") do
      describe ("に#{ timeserver[:server] }が記載されていること") do
        its(:content) { should match /^server\s+#{ timeserver[:server] }\s/ }
      end

      describe ("preferオプションが記載されていること"), :if => timeserver[:prefer] == TRUE do
        its(:content) { should match /^server\s+#{ timeserver[:server] }\s.+prefer\s*$/ }
      end
    end
  end

  describe ("ntpq -pコマンドの結果に*で始まるサーバが存在していること") do
    describe command("ntpq -p") do
      its(:stdout) { should match /^\*[^\*]/ }
    end
  end
end

describe ("097-NTP_Option") do
  begin
    ntp_option = property[:ADVANCED][:ntp_option]
  rescue NoMethodError
    ntp_option = nil
  end

  next if ntp_option == nil

  describe file('/etc/sysconfig/ntpd') do
    describe ("のOPTIONSの値に-xが含まれていること"), :if => ntp_option[:slew] == TRUE do
      its(:content) { should match /^OPTIONS=.+-x/ }
    end
  end
end


