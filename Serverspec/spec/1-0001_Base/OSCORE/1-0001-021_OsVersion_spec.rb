describe ("021-OSversion") do
  begin
    version = property[:BASE][:OSCORE][:version]
  rescue NoMethodError
    version = nil
  end

  describe ("OSバージョンが#{ version }であること"), :if => version != nil do
    it { expect( os[:release] ).to eq version.to_s }
  end 
end
