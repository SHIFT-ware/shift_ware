

describe ("092-Syslog") do

  #---------------------------
  # CAUTION: 極限定的な実装です。rsyslogかつsyslogのフィルタ（facilty.priority）しか対応してません。
  #---------------------------

  begin
    filters = property[:ADVANCED][:syslog][:filters]
  rescue NoMethodError
    filters = nil
  end

  next if filters == nil

  filters.each do |filter|
    describe ("#{ filter[:selector] }の出力先が#{ filter[:output] }であること"),:if => filter[:selector] != nil do
      describe file('/etc/rsyslog.conf') do
        its(:content) { should match /^#{ Regexp.escape(filter[:selector]) }\s+#{ Regexp.escape(filter[:output]) }\s*$/ }
      end
    end
  end
end

