describe ("071-Hostname") do
  begin
    hostname = property[:NETWORK][:hostname]
  rescue NoMethodError
    hostname = nil
  end

  describe ("ホスト名が#{ hostname }であること"), :if => hostname != nil do
    describe command('uname -n') do
      its(:stdout) { should match /^#{ Regexp.escape(hostname) }$/ }
    end
  end
end

