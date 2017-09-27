describe ("095-Packages")do

  begin
    packages = property[:ADVANCED][:packages]
  rescue NoMethodError
    packages = nil
  end

  next if packages == nil

  packages.each do |package|
    describe package(package[:name])do
      context ("#{ package[:name] }パッケージがインストールされていること"), :if => package[:version] == nil do
        it { should be_installed }
      end

      context ("#{ package[:name] }パッケージversion#{ package[:version] }がインストールされていること"), :if => package[:version] != nil do
        it { should be_installed.with_version(package[:version]) }
      end
    end
  end
end
