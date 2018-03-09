describe "098-Ssh" do
  context "/etc/ssh/sshd_configの" do
    subject(:sshd_config){ file('/etc/ssh/sshd_config') }
    setting = {true: "yes", false: "no"}

    permit_root_login  = setting[ property.dig(:ADVANCED, :sshd, :permit_root_login).to_s.to_sym ]

    it "PermitRootLoginが#{permit_root_login}であること", if: permit_root_login != nil do
      expect(sshd_config.content).to match /^PermitRootLogin\s+#{permit_root_login}\s*/
    end

    password_auth = setting[ property.dig(:ADVANCED, :sshd, :password_auth).to_s.to_sym ]
    
    it "PasswordAuthenticationが#{password_auth}であること", if: password_auth != nil do
      expect(sshd_config.content).to match /^PasswordAuthentication\s+#{password_auth}\s*$/
    end
  end
end



