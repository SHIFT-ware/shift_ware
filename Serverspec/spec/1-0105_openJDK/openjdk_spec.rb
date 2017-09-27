require 'spec_helper'

describe ("1-0105_openJDK") do
  version = property[:openjdk][:version] rescue nil
  install_devel = property[:openjdk][:install_devel] rescue nil

  next if version == nil

  describe ("パッケージjava-#{ version }-openjdkがインストールされていること") do
    describe package("java-#{ version }-openjdk") do
      it { should be_installed }
    end
  end

  describe ("パッケージjava-#{ version }-openjdk-develがインストールされていること"), :if => install_devel == true do
    describe package("java-#{ version }-openjdk-devel") do
      it { should be_installed }
    end
  end
end
