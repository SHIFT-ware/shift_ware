
describe ("028-Grub") do

  begin
    grub_options = property[:BASE][:OSCORE][:grub_option]
  rescue NoMethodError
    grub_options = nil
  end

  next if grub_options == nil

  grub_options.each do |grub_option|
    describe ("のoption設定として#{ grub_option[:key] }が#{ grub_option[:value] }であること"), :if => grub_option[:key] != nil do
      context file("/etc/grub.conf"), :if=> os[:release].include?("6.") do
        its(:content) { should match /^#{ grub_option[:key] }=#{ grub_option[:value] }\s*$/ }
      end

      context file("/etc/default/grub"), :if=> os[:release].include?("7.") do
        its(:content) { should match /^#{ grub_option[:key] }\s*=\s*#{ grub_option[:value] }\s*$/ }
      end
    end
  end
end

