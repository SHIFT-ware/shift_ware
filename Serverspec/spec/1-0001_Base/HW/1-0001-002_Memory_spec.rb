describe ("002-Memory") do
  begin
    mem_size = property[:BASE][:HW][:mem_size]
  rescue NoMethodError
    mem_size = nil
  end

  if mem_size != nil
    ret = Specinfra::Runner.run_command("grep ^MemTotal: /proc/meminfo | awk '{ print $2 }'").stdout
    ret = ret.to_i

    min = mem_size * 0.85
    max = mem_size * 1.0
  end

  describe (" 物理メモリサイズが#{mem_size}の85%～100%の範囲内か"), :if => mem_size != nil  do
    it { ( expect(ret).to  be >= min ) && (expect(ret).to  be <= max ) }
  end
end
