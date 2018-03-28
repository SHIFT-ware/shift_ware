describe "011_User" do
  context "ユーザー" do
    users = property.dig(:BASE, :ID, :user).to_a

    users.each do |user|
      it "#{user[:name]}が存在すること" do
	user_config = user(user[:name])
	expect(user_config).to exist
      end

      it "#{user[:name]}のuidが#{user[:uid]}であること", if: user.has_key?(:uid) do
	user_config = user(user[:name])
	expect(user_config).to have_uid user[:uid]
      end

      it "#{user[:name]}が#{user[:group]}に所属すること", if: user.has_key?(:group) do
	user_config = user(user[:name])
	expect(user_config).to belong_to_primary_group user[:group]
      end

      it "#{user[:name]}のホームディレクトリが#{user[:home_dir]}であること", if: user.has_key?(:home_dir) do
	user_config = user(user[:name])
	expect(user)_config.to have_home_directory user[:home_dir]
      end

      it "#{user[:name]}のログインシェルが#{user[:shell]}であること", if: user.has_key?(:shell) do
	user_config = user(user[:name])
	expect(user_config).to have_login_shell user[:shell]
      end

      it "#{user[:name]}がセカンダリグループとして#{user[:sub_groups]}に所属していること", if: user.has_key?(:sub_groups) do
        sub_groups = user[:sub_groups].split(",")
        stdouts = sub_groups.map { |sub_group| command("grep '^#{sub_group}:' /etc/group").stdout }
        expect(stdouts).to all match /(:|,)#{user[:name]}(,|\s*$)/
      end
    end
  end
end
