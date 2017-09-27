
    
describe("011-OSユーザ")do
  begin
    users = property[:BASE][:ID][:user]
  rescue NoMethodError
    users = nil
  end

  next if users == nil

  users.each do |user|
    name = user[:name]
    uid = user[:uid]
    group = user[:group]
    home_dir = user[:home_dir]
    shell = user[:shell]
    sub_groups = user[:sub_groups]

    describe user(name) do
      describe ("ユーザが存在すること") do
        it { should exist }
      end
      
      describe ("のuidが#{uid}であること"), :if => uid != nil do
        it { should have_uid "#{uid}" }
      end
      
      describe ("が#{group}に所属すること"),:if => group != nil do
        it { should belong_to_group "#{group}" }
      end
      
      describe ("のホームディレクトリが#{home_dir}であること"), :if => home_dir != nil do 
        it { should have_home_directory "#{home_dir}" }
      end
      
      describe ("のログインシェルが#{shell}であること"), :if => shell != nil do
        it { should have_login_shell "#{shell}"}
      end
      
      describe ("がセカンダリグループとして#{sub_groups.to_s}に所属していること") , :if => sub_groups != nil do
        sub_groups.to_s.split(",").each do |sub_group|
          describe command("grep '^#{sub_group}:' /etc/group") do
            its(:stdout) { should match /(:|,)#{name}(,|\s*$)/ } 
          end
        end
      end
    end
  end
end
