describe ("1-0106-02_ValidityCert") do
  pem_file = "#{ property[:PrivateCA][:install_path] }/#{ property[:PrivateCA][:ca_cert][:pem_filename] }"
  validity_start = Specinfra.backend.run_command("date -d \"\`openssl x509 -in #{ pem_file } -noout -startdate | cut -c 11-\`\" \"+%s\"").stdout
  validity_end = Specinfra.backend.run_command("date -d \"\`openssl x509 -in #{ pem_file } -noout -enddate | cut -c 10-\`\" \"+%s\"").stdout

  validity_term = property[:PrivateCA][:ca_cert][:csr_validity_term]
  it "check validity term" do
    expect((validity_end.to_i - validity_start.to_i)/86400).to eq validity_term
  end
end
