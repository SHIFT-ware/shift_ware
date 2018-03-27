describe "011_User" do
  context "ユーザー" do
    users = property.dig(:BASE, :ID, :user).to_a

    users.each do |user|
      it "#{user[:name]}が存在すること" do
	expect(user).to exist
      end

      it "#{user[:name]}のuidが#{user[:uid]}であること", if: user.has_key?(:uid) do
	expect(user).to have_uid user[:uid]
      end

      it "#{user[:name]}が#{user[:group]}に所属すること", if: user.has_key?(:group) do
	expect(user).to belong_to_primary_group user[:group]
      end

      it "#{user[:name]}のホームディレクトリが#{user[:home_dir]}であること", if: user.has_key?(:home_dir) do
	expect(user).to have_home_directory user[:home_dir]
      end

      it "#{user[:name]}のログインシェルが#{user[:shell]}であること", if: user.has_key?(:shell) do
	expect(user).to have_login_shell user[:shell]
      end

      it "#{user[:name]}がカンダリグループとして#{user[:sub_groups]}に所属していること", if: user.has_key?(:sub_groups) do
        user[:sub_groups].split(",").each do |sub_group|
	  stdout = command("grep '^#{sub_group}:' /etc/group").stdout
	  expect(stdout).to match /(:|,)#{name}(,|\s*$)/
	end
      end
    end
  end
end
