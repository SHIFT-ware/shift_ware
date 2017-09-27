describe ("1-0108_Pgpool-II(package and service)") do
  describe ("pgpool") do
    describe ("のパッケージがインストールされていること") do
      describe command('rpm -qa pgpool-II*') do
        its(:stdout) { should match /^pgpool-II.*/ }
      end
    end
    describe service("pgpool") do
      state = property[:Pgpool][:state] rescue nil
      describe ("のサービスが#{ state }であること") do
        case state
        when "started"
          it { should be_running }
        when "stopped"
          it { should_not be_running }
        when nil
        else
          raise "パラメータPgpool.stateの値が不正です"
        end
      end

      enabled = property[:Pgpool][:enabled] rescue nil
      describe ("のサービスの自動起動設定が#{ enabled }であること"), :if => enabled != nil do
        case enabled
        when true
          it { should be_enabled }
        when false
          it { should_not be_enabled }
        end
      end
    end
  end
end
