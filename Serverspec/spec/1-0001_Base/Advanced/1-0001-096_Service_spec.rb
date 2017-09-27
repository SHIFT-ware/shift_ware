describe ("096-service") do
  begin
    services = property[:ADVANCED][:service]
  rescue NoMethodError
    services = nil
  end

  next if services == nil

  services.each do |service|
    raise "テストに必要なパラメータADVANCED.service.nameが不足しています" if service[:name] == nil

    context service(service[:name]) do
      describe ("#{ service[:name] }サービスが#{ service[:state] }であること") do
        it { should be_running } if service[:state] == TRUE
        it { should_not be_running } if service[:state] == FALSE
      end

      describe ("#{ service[:name] }サービスの設定が#{ service[:enable] }であること") do
        it { should be_enabled } if service[:enable] == TRUE
        it { should_not be_enabled } if service[:enable] == FALSE
      end 
    end
  end
end
