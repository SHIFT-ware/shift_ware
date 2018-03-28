describe "013_PasswordPolicy" do
  context "パスワードポリシー( /etc/login.defs )" do
    password_policy = property.dig(:BASE, :ID, :password_policy)
    next if password_policy == nil

    subject(:password_policy_resource){ file("/etc/login.defs") }

    it "のパスワード期限（日数）が#{password_policy[:max_days]}であること", if: password_policy.has_key?(:max_days) do
      expect(password_policy_resource.content).to match /^PASS_MAX_DAYS\s+#{password_policy[:max_days]}\s*$/
    end

    it "のパスワードの変更不可期間（日数）が#{password_policy[:min_days]}であること", if: password_policy.has_key?(:min_days) do
      expect(password_policy_resource.content).to match /^PASS_MIN_DAYS\s+#{password_policy[:min_days]}\s*$/
    end

    it "のパスワードの最小文字数が#{password_policy[:min_length]}であること", if: password_policy.has_key?(:min_length) do
      expect(password_policy_resource.content).to match /^PASS_MIN_LEN\s+#{password_policy[:min_length]}\s*$/
    end

    it "のパスワード期限切れの警告を#{password_policy[:warn_age]}日前からする設定であること", if: password_policy.has_key?(:warn_age) do
      expect(password_policy_resource.content).to match /^PASS_WARN_AGE\s+#{password_policy[:warn_age]}\s*$/
    end
  end
end
