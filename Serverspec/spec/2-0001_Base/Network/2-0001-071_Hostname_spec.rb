if property[:NETWORK] != nil then
  if property[:NETWORK][:hostname] != nil then

    describe ("071-Hostname") do

      h=property[:NETWORK][:hostname].upcase

      describe ("コンピュータ名が #{ h } であること"), :if => h != nil do
        describe command("Write-Host -NoNewline (hostname).ToUpper()") do
          its(:stdout) { should eq "#{ h }" }
        end
      end

    end

  end
end
