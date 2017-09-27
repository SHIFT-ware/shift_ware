describe ("100_Product") do
  begin
    products = Array(property[:ADVANCED][:product])
  rescue
    products = []
  end

  describe command("(Get-WmiObject -Class Win32_Product).Name") do
    products.each do |product|
      describe ("製品[#{ product[:name] }] がインストールされていること"), :if => product[:name] != nil do
        its(:stdout) { should match /(\A|\R)#{Regexp.escape(product[:name])}\s*(\A|\R)/ }
      end
    end
  end
end
