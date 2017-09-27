describe ("098-Ssh") do
  begin
    sshd = property[:ADVANCED][:sshd]
  rescue NoMethodError
    sshd = nil
  end

  next if sshd == nil

  describe file('/etc/ssh/sshd_config') do
    describe ("rootで直接ssh接続できる設定になっていること"), :if => sshd[:permit_root_login] == TRUE do
      its(:content) { should_not match /^PermitRootLogin\s+no\s*$/ }
    end

    describe ("password認証が可能なこと"), :if => sshd[:password_auth] == TRUE do
      its(:content) { should_not match /^PasswordAuthentication\s+no\s*$/ }
    end
  end 
end
