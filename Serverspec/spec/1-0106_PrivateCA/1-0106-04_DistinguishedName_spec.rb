ca_cert = property[:PrivateCA][:ca_cert]
install_path = property[:PrivateCA][:install_path]

describe ("1-0106-04_DistinguishedName") do
  describe ("check standard DN + option mail") do
    pem_file = "#{install_path}/#{ca_cert[:pem_filename]}"
    country = ca_cert[:distinguished_name][:country]
    state = ca_cert[:distinguished_name][:state]
    locality_name = ca_cert[:distinguished_name][:locality_name]
    organization = ca_cert[:distinguished_name][:organization]
    unit_name = ca_cert[:distinguished_name][:unit_name]
    common_name = ca_cert[:distinguished_name][:common_name]
    email = ca_cert[:distinguished_name][:email] rescue nil
    if email != nil
      test_cmd = <<-EOF
        openssl x509 -in #{ pem_file } -noout -text | grep \\
          \"Subject: C=#{ country }, ST=#{ state }, L=#{ locality_name }, O=#{ organization }, OU=#{ unit_name }, CN=#{ common_name }//emailAddress=#{ email }\"
      EOF
      describe command(test_cmd) do
      end
    else
      test_cmd = <<-EOF
        openssl x509 -in #{ pem_file } -noout -text | grep \\
          \"Subject: C=#{ country }, ST=#{ state }, L=#{ locality_name }, O=#{ organization }, OU=#{ unit_name }, CN=#{ common_name }\"
      EOF
      describe command("test_cmd") do
        its(:exit_status) { should eq 0 }
      end
    end
  end
end
