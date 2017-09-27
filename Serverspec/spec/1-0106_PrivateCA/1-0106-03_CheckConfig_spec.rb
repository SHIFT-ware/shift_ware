policy_match_start = Specinfra.backend.run_command("grep -n \"\\[ policy_match\" /etc/pki/tls/openssl.cnf | awk -F: \'{ print $1 }\'").stdout
policy_match_end = Specinfra.backend.run_command("grep -n \"\\[ policy_anything\" /etc/pki/tls/openssl.cnf | awk -F: \'{ print $1 }\'").stdout
policy_match_row_count = policy_match_end.to_i - policy_match_start.to_i

ca_default_start = Specinfra.backend.run_command("grep -n \"\\[ CA_default\" /etc/pki/tls/openssl.cnf | awk -F: \'{ print $1 }\'").stdout
ca_default_end = Specinfra.backend.run_command("grep -n \"\\[ policy_match\" /etc/pki/tls/openssl.cnf | awk -F: \'{ print $1 }\'").stdout
ca_default_row_count = ca_default_end.to_i - ca_default_start.to_i

describe ("1-0106-03_CheckConfig") do
  describe ("check localityName policy") do
    describe command("grep \"\\[ policy_match\" -A #{ policy_match_row_count - 1 } /etc/pki/tls/openssl.cnf  | grep localityName") do
      its(:stdout) { should match /^localityName\s*=\s*match\s*$/}
    end
  end

  describe ("check copy_extensions option") do
    describe command("grep \"\\[ CA_default\" -A #{ ca_default_row_count - 1 } /etc/pki/tls/openssl.cnf  | grep copy_extensions") do
      its(:stdout) { should match /^copy_extensions\s*=\s*copy\s*$/}
    end
  end
end

