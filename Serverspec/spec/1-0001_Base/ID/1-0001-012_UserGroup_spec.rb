describe " 012_UserGroup" do
  context "ユーザーグループ" do
    users = property.dig(:BASE, :ID, :user_group).to_a

    user_groups.each do |user_group|
      it "#{user_group[:name]}が存在すること" do
        group_resource = group(user_group[:name])
        expect(group_resource).to exist
      end

      it "#{user_group[:name]}のgidが#{user_group[:gid]}であること" if: user_group.has_key?(:gid) do
        group_resource = group(user_group[:name])
        expect(group_resource).to have_gid user_group[:gid]
      end
    end
  end
end

