describe ("099-Snmp") do
  describe file('/etc/snmp/snmpd.conf') do
    begin
      snmpd= property[:ADVANCED][:snmpd]
    rescue NoMethodError
      snmpd = nil
    end

    next if snmpd == nil

    secs = snmpd.fetch(:sec, [])
    traps = snmpd.fetch(:trap, [])

    secs.each do |sec|
      describe ("sec.name=#{ sec[:sec_name] },source=#{ sec[:source] },community=#{ sec[:community] }の登録がされていること"), :if => sec[:sec_name] != nil do
        its(:content) { should match /^com2sec\s+#{ sec[:sec_name] }\s+#{ sec[:source] }\s+#{ sec[:community] }\s*$/ }
      end
    end

    traps.each do |trap|
      describe ("snmp trapが#{ trap[:server]}:#{ trap[:port] }の#{ trap[:community] }に行われる設定がされていること"), :if => trap[:server] != nil do 
        its(:content) { should match /^trapsink\s+#{ trap[:server] }#{ trap[:community] != nil ? "\s+" + trap[:community].to_s : "" }#{ trap[:port] != nil ? "\s+" + trap[:port].to_s : "" }\s*$/ }
      end
    end
  end
end
