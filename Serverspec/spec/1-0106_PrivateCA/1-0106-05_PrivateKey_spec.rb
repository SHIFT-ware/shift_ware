ca_cert = property[:PrivateCA][:ca_cert]
install_path = property[:PrivateCA][:install_path]
private_key_file = "#{ install_path }/private/#{ ca_cert[:private_key_filename] }"
private_key_length = ca_cert[:private_key_length]
pem_file = "#{ install_path }/#{ ca_cert[:pem_filename] }"
private_key_passphrase = ca_cert[:private_key_passphrase]

describe ("1-0106-05_PrivateKey") do
  describe ("check ca private key") do
    describe file(private_key_file) do
      it { should exist }
    end
  end

  describe ("check length") do
    describe command("openssl x509 -in #{ pem_file } -noout -text | grep \"Public-Key: (#{ private_key_length } bit)\"") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe ("check passphrase") do
    describe command("openssl rsa -in #{ private_key_file } -passin pass:#{ private_key_passphrase }") do
      its(:exit_status) { should eq 0 }
    end
  end
end
