
describe ("106_Registry")do
  begin
    registries = Array( property[:ADVANCED][:registry])
  rescue
    registries = []
  end

  registries.each do |registry|
    key = registry[:key]
    values = registry[:value]

    raise "テストに必要なパラメータADVANCED.registry.{key,value}が不足しています" if key == nil || values == nil
    describe ("レジストリキー[#{ key }]") do
      values.each do |value|

        raise "テストに必要なパラメータADVANCED.registry.value.nameが不足しています" if value[:name] == nil

        describe ("に名前 #{ value[:name] } が存在すること") do
          describe command("(Get-Item 'Registry::#{ key }').Property") do
            its(:stdout) { should match /(\A|\R)#{ value[:name] }(\R|\Z)/}
          end
        end

        describe ("の名前 #{ value[:name] } の種類が #{ value[:type] } であること"), :if => value[:type] != nil do
          describe command("Write-Host -NoNewline (Get-Item 'Registry::#{ key }').GetValueKind('#{ value[:name] }')") do
            its(:stdout) { should eq "#{ value[:type] }" }
          end
        end

        describe ("に名前 #{ value[:name] } が存在すること") do
          describe command("(Get-Item 'Registry::#{ key }').Property") do
            its(:stdout) { should match /(\A|\R)#{ value[:name] }(\R|\Z)/}
          end
        end

        describe ("の名前 #{ value[:name] } の種類が #{ value[:type] } であること"), :if => value[:type] != nil do
          describe command("Write-Host -NoNewline (Get-Item 'Registry::#{ key }').GetValueKind('#{ value[:name] }')") do
            its(:stdout) { should eq "#{ value[:type] }" }
          end
        end

        describe ("の名前 #{ value[:name] } のデータが #{ value[:data] } であること"), :if => value[:data] != nil do
          describe command("Write-Host -NoNewline (Get-Item 'Registry::#{ key }').GetValue('#{ value[:name] }')") do
            its(:stdout) { should eq "#{ value[:data] }" }
          end
        end
      end
    end
  end
end


