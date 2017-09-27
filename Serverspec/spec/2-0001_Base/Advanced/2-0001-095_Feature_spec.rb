describe ("095_Feature") do
  begin
    features = Array(property[:ADVANCED][:feature])
  rescue
    features = []
  end

  describe command("(Get-WindowsFeature | Where-Object {$_.Installed -eq $True}).Path") do
    features.each do |feature|
      describe ("役割と機能[#{ feature[:name] }] がインストールされていること"), :if => feature[:name] != nil do
        its(:stdout) { should match /(\A|\R)#{Regexp.escape(feature[:name])}(\R|\Z)/ }
      end
    end
  end
end

