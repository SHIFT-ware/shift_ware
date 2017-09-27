describe("024-Timezone")do
  begin
    timezone = property[:BASE][:OSCORE][:timezone]
  rescue
    timezone = nil
  end

  next if timezone == nil

  describe ("Timezoneが #{ timezone } であること") do
    describe command('Write-Host -NoNewline (tzutil /g)')do
      its(:stdout) { should match /\A#{ timezone }(\s|\Z)/ }
    end
  end
end
