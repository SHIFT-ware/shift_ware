#test
describe ("012-UserGroup")do
  begin
    groups = Array(property[:BASE][:ID][:group])
  rescue
    groups = []
  end

  groups.each do |user_group|
    describe group("#{user_group[:name]}") do
      describe("groupが存在すること")do
        it { should exist }
      end
    end
  end
end
