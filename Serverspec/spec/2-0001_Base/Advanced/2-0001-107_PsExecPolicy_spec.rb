describe ("107_PsExecPolicy")do

  begin
    psexecpolicy = property[:ADVANCED][:psexecpolicy]
  rescue
    psexecpolicy = nil
  end

  describe ("Powershellの実行ポリシー") do
    describe ("が LocalMachine スコープにおいて #{ psexecpolicy } であること"), :if => psexecpolicy != nil do
      describe command('Write-Host -NoNewLine (Get-ExecutionPolicy -Scope LocalMachine)') do
        its(:stdout) { should eq "#{ psexecpolicy }" }
      end
    end
  end
end
