describe ("053_Cdrom")do

  begin
    cdroms = Array(property[:STORAGE][:cdrom])
  rescue
    cdroms = []
  end

  cdroms.each do |cdrom|
    describe ("CD-ROMドライブ[#{ cdrom[:drive_letter] }]"), :if => cdrom[:drive_letter] != nil do
      describe ("が存在すること")do
        describe command("(Get-Volume | Where-Object {$_.DriveType -eq 'CD-ROM'}).DriveLetter") do
          its(:stdout) { should match /(\A|\R)#{cdrom[:drive_letter]}(\R|\Z)/ }
        end
      end
    end
  end
end
