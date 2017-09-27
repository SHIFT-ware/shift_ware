describe ("025-runlevel") do
  begin
    runlevel = property[:BASE][:OSCORE][:runlevel]
  rescue NoMethodError
    runlevel = nil
  end

  describe ("現在のランレベルが#{runlevel}であること"), :if => runlevel != nil do
    describe command('runlevel') do #RHEL7系では推奨ではないが現状は互換性があるので大丈夫。
      its(:stdout) { should match /.\s#{ runlevel }/ }
    end
  end
end

