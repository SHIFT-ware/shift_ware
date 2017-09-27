
if property[:NETWORK] != nil then
  
  describe ("073-Routing") do
    
    d = property[:NETWORK]
    describe ("デフォルトゲートウェイが #{ d[:default_gw] } であること"), :if => d[:default_gw] != nil do
      describe command ("route print '0.0.0.0' -4") do
        its(:stdout) { should match /\s0\.0\.0\.0\s+0\.0\.0\.0\s+#{ d[:default_gw] }\s/ }
      end
    end
  
    if d[:static_routing] != nil
      d[:static_routing].each do |s|
        describe ("スタティックルートとして 宛先ネットワーク: #{ s[:dest] }, サブネットマスク: #{ s[:mask] }, ゲートウェイ: #{ s[:gw] } の設定が存在すること") do
          describe command("route print -4") do
            its(:stdout) { should match /\s#{ s[:dest] }\s+#{ s[:mask] }\s+#{ s[:gw] }\s/ }
          end
        end
      end
    end
    
  end

end
