describe ("093-Cron") do
  begin
    entries = property[:ADVANCED][:cron][:entry]
  rescue NoMethodError
    entries = nil
  end
  
  next if entries == nil

  entries.each do |entry|
    describe ("cronに#{ entry[:record] }のエントリがあること"), :if => entry[:record] != nil do
      context cron do
        it { should have_entry(entry[:record]) } if entry[:usr] == nil
        it { should have_entry(entry[:record]).with_user(entry[:usr]) } if entry[:usr] != nil
      end
    end
  end 
end
