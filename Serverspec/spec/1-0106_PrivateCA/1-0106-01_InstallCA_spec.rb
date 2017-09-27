describe ("1-0106-01_InstallCA") do
  describe ("install path check") do
    install_path = property[:PrivateCA][:install_path]
    describe file(install_path) do
      it { should exist }
    end
  end

  describe ("check ca cert (pem)") do
    pem_file = "#{ property[:PrivateCA][:install_path] }/#{ property[:PrivateCA][:ca_cert][:pem_filename] }"
    describe file(pem_file) do
      it { should exist }
    end
  end

  describe ("check ca cert (der)") do
    der_file = "#{ property[:PrivateCA][:install_path] }/#{ property[:PrivateCA][:ca_cert][:der_filename] }"
    describe file(der_file) do
      it { should exist }
    end
  end
end

