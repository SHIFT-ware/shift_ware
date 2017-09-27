

describe (" 012_UserGroup") do
  begin
    user_groups = property[:BASE][:ID][:user_group]
  rescue NoMethodError
    user_groups = nil
  end

  next if user_groups == nil

  user_groups.each do |user_group|
    name = user_group[:name]
    gid = user_group[:gid]

    describe group(name) do
      describe ("グループが存在すること") do
        it { should exist }
      end

      describe ("グループのgidが#{gid}であること"), :if => gid != nil do
        it { should have_gid gid }
      end
    end
  end
end

