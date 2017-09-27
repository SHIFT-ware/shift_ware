

describe ("051-Partition") do
  begin
    mount_points = property[:BASE][:ID][:mount_point]
  rescue NoMethodError
    mount_points = nil
  end

  next if mount_points == nil

  mount_points.each do |mount_point|

    path = mount_point[:path]
    device_file_name = mount_point[:device_file_name]
    file_system = mount_point[:file_system]
    size = mount_point[:size]

    context file("#{ path }") do
      describe ("のデバイスファイルが#{ device_file_name }であること"), :if => device_file_name != nil do
        it { should be_mounted.with( :device => "#{ device_file_name }") }
      end

      describe ("のファイルシステムが#{ file_system }であること"), :if => file_system != nil do
        it { should be_mounted.with( :type => "#{ file_system }") }
      end

      if size != nil
        ret = Specinfra::Runner.run_command("df -m -P | grep #{ path }$ | awk '{ print $2 }'").stdout
        ret = ret.to_i  # 直接↑の行で.stdout.to_iでやると取れないので仕方なく。。。Str to Intができない
        min = size.to_i * 0.9
        max = size.to_i * 1.0
      end

      describe ("のサイズが#{ size }の90～100%であること"), :if=> size != nil do
        it { ( expect(ret).to be >= min ) && ( expect(ret).to be <= max ) } #Rspecでint →l long に変換してるのでlog上変な少数が入る
      end
    end
  end
end
