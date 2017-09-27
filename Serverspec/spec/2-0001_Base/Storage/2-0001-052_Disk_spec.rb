describe ("052_Disk")do

  begin
    disks = Array(property[:STORAGE][:disk])
  rescue
    disks = []
  end

  disks.each do |disk|

    describe ("ディスク[#{ disk[:number] }]") do
      describe ("が存在すること") do
        describe command("(Get-Disk).Number") do
          its(:stdout) { should match /(\A|\R)#{ disk[:number] }(\R|\Z)/ }
        end
      end

      describe ("のパーティションのスタイルが #{ disk[:partition_style] } であること"), :if => disk[:partition_style] != nil do
        describe command("Write-Host -NoNewLine ((Get-Disk -Number '#{ disk[:partition_type] }').PartitionStyle)") do
          its(:stdout) { should eq "#{disk[:partition_style]}" }
        end
      end

      if disk[:total_size] != nil
        ret = Specinfra::Runner.run_command("Write-Host -NoNewline ((Get-Disk -Number '#{disk[:number]}').Size/1GB)").stdout
        ret = ret.to_i  # 直接↑の行で.stdout.to_iでやると取れないので仕方なく。。。Str to Intができない
        min = disk[:total_size].to_i * 0.9
        max = disk[:total_size].to_i * 1.0
      end

      describe ("の全体容量が #{ disk[:total_size] }GB の 90～100% であること"), :if => disk[:total_size] != nil do
        it { expect(ret).to be <= max } #Rspecでint →l long に変換してるのでlog上変な少数が入る
        it { expect(ret).to be >= min } #Rspecでint →l long に変換してるのでlog上変な少数が入る
      end
    end

    begin
      partitions = Array(disk[:partition])
    rescue
      partitions = []
    end

    partitions.each do |partition|
      describe ("の パーティション[#{ partition[:drive_letter] }]") do
        describe ("が存在すること") do
          describe command("(Get-Partition -DiskNumber #{disk[:number]}).DriveLetter") do
            its(:stdout) { should match /(\A|\R)#{ partition[:drive_letter] }(\R|\Z)/ }
          end
        end

        describe ("のファイルシステムが #{partition[:filesystem]} であること"), :if => partition[:filesystem] != nil do
          describe command("Write-Host -NoNewLine ((Get-Volume -DriveLetter '#{partition[:drive_letter]}').FileSystem)") do
            its(:stdout) { should eq "#{partition[:filesystem]}" }
          end
        end

        describe ("のボリュームラベルが #{partition[:volume_label]} であること"), :if => partition[:volume_label] != nil do
          describe command("Write-Host -NoNewLine ((Get-Volume -DriveLetter '#{partition[:drive_letter]}').FileSystemLabel)") do
            its(:stdout) { should eq "#{partition[:volume_label]}" }
          end
        end

        describe ("のアロケーションユニットサイズが #{partition[:au_size]} であること"), :if => partition[:au_size] != nil do
          describe command("Write-Host -NoNewLine ((Get-WmiObject -Query \"SELECT * FROM Win32_Volume WHERE DriveLetter='#{partition[:drive_letter]}:'\").BlockSize)") do
            its(:stdout) { should eq "#{partition[:au_size]}" }
          end
        end

        describe ("のドライブ圧縮フラグが #{partition[:archive]} であること"), :if => partition[:archive] != nil do
          describe command("Write-Host -NoNewLine ((Get-WmiObject -Query \"SELECT * FROM Win32_Volume WHERE DriveLetter='#{partition[:drive_letter]}:'\").Compressed)") do
            its(:stdout) { should eq "#{partition[:archive]}" }
          end
        end

        if partition[:size] != nil
          ret = Specinfra::Runner.run_command("Write-Host -NoNewline ((Get-Volume -DriveLetter '#{partition[:drive_letter]}').Size/1GB)").stdout
          ret = ret.to_i  # 直接↑の行で.stdout.to_iでやると取れないので仕方なく。。。Str to Intができな
          min = partition[:size].to_i * 0.9
          max = partition[:size].to_i * 1.0
        end

        describe ("の容量が #{ partition[:size] }GB の 90～100% であること"), :if => partition[:size] != nil do
          it { expect(ret).to be <= max } #Rspecでint →l long に変換してるのでlog上変な少数が入
          it { expect(ret).to be >= min } #Rspecでint →l long に変換してるのでlog上変な少数が入
        end
      end
    end

  end

end
