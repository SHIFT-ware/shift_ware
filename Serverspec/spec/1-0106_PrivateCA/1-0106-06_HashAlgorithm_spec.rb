install_path = property[:PrivateCA][:install_path]
ca_cert = property[:PrivateCA][:ca_cert]
pem_file = "#{ install_path }/#{ ca_cert[:pem_filename] }"
hash_algorithm = ca_cert[:hash_algorithm]

describe ("1-0106-06_HashAlgorithm") do
  describe ("check hash algorithm") do
    describe ("openssl x509 -in #{ pem_file } -noout -text | grep \"Signature Algorithm: #{ hash_algorithm }WithRSAEncryption\"")
  end
end
