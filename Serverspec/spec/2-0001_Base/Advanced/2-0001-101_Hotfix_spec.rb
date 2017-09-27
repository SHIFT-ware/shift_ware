describe ("101_Hotfix")do
  begin
    hotfixes = Array(property[:ADVANCED][:hotfix])
  rescue
    hotfixes = []
  end

  describe command("(Get-Hotfix).HotfixID") do
    hotfixes.each do |hotfix|
      describe ("Hotfix[#{ hotfix[:id] }] がインストールされていること"), :if => hotfix[:id] != nil do
        its(:stdout) { should match /(\A|\R)#{ hotfix[:id] }(\R|\Z)/ }
      end
    end
  end
end
