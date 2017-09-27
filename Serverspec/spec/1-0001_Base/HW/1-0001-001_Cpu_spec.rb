describe("001-CPUテスト") do
  begin
    cpu_core_sum = property[:BASE][:HW][:cpu_core_sum]
  rescue NoMethodError
    cpu_core_sum = nil
  end

  describe (" CPUの総コア数が#{cpu_core_sum}であること"), :if => cpu_core_sum != nil do
    describe command('lscpu | grep ^CPU\(s\)') do
      its(:stdout) { should match /\s#{cpu_core_sum}$/ }
    end
  end


  begin
    cpu_hyper_thread = property[:BASE][:HW][:cpu_hyper_thread]
  rescue NoMethodError
    cpu_hyper_thread = nil
  end

  describe (" CPUのハイパースレッドの設定が#{cpu_hyper_thread}であること"), :if => cpu_hyper_thread != nil do
    describe command('lscpu | grep "^Thread(s)\s\+per\s\+core:"') do
      if cpu_hyper_thread                           # on の場合、trueになる
        its(:stdout) { should match /\s+2/ }        # on の場合、HTでper coreは2に。
      else
        its(:stdout) { should match /\s+1/ }
      end
    end
  end
end

