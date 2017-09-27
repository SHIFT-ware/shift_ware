describe ("022-OsLang") do
  begin
    lang = property[:BASE][:OSCORE][:lang]
  rescue NoMethodError
    lang = nil
  end

  next if lang == nil

  describe ("OS Default Languageが#{lang}であること"),:if => lang != nil do
    context file('/etc/sysconfig/i18n'), :if => os[:release].include?("6.") do
      its(:content) { should match "^LANG=\"#{lang}\"" }
    end

    context file('/etc/locale.conf'), :if => os[:release].include?("7.") do
      its(:content) { should match "^LANG=\"#{lang}\"" }
    end
  end    
end
