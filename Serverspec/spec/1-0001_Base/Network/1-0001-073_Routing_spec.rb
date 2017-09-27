describe ("073-Routing") do
  describe default_gateway do
    begin
      default_gw = property[:NETWORK][:default_gw]
    rescue NoMethodError
      default_gw = nil
    end

    next if default_gw == nil

    describe ("のIPアドレスが#{ default_gw[:addr] }であること"), :if => default_gw[:addr] != nil do
      its(:ipaddress) { should eq default_gw[:addr] }
    end

    describe ("のインターフェイスが#{ default_gw[:if] }であること"), :if => default_gw[:if] != nil do
      its(:interface) { should eq default_gw[:if] }
    end
  end


  describe routing_table do
    begin
      static_routings = property[:NETWORK][:static_routing]
    rescue NoMethodError
      static_routings = nil
    end

    next if static_routings == nil

    static_routings.each do |static_routing|
      describe ("destination=#{ static_routing[:dest] }, gw=#{ static_routing[:gw] }のstatic routeがあること"), :if => static_routing[:dest] != nil do
        it do
          should have_entry(
            :destination => "#{ static_routing[:dest] }",
            :interface => "#{ static_routing[:if] }",
            :gateway => "#{ static_routing[:gw] }",
          )
        end
      end
    end
  end
end

