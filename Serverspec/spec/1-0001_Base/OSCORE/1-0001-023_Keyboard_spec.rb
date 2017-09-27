
describe("023-Keyboard")do

  begin
    keybord_locale = property[:BASE][:OSCORE][:keyboard][:keybord_locale]
  rescue NoMethodError
    keybord_locale = nil
  end

  next if keybord_locale == nil

  describe file('/etc/sysconfig/keyboard'), :if => os[:release].include?("6.") do
    describe ("KEYTABLEが#{keybord_locale}であること") do
      its(:content) { should match /^KEYTABLE.+\"#{ Regexp.escape(keybord_locale) }\"/ }
    end
  end

  describe command('localectl status'), :if => os[:release].include?("7.") do
    describe ("VC Keymapが#{ keybord_locale }であること") do
      its(:stdout) { should match /^       VC Keymap: #{ Regexp.escape(keybord_locale) }$/ }
    end

    describe ("X11 Layoutが#{ keybord_locale }であること") do
      its(:stdout) { should match /^      X11 Layout: #{ Regexp.escape(keybord_locale) }$/ }
    end
  end
end
