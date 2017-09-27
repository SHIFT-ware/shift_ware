describe ("013_PasswordPolicy") do
  begin
    password_policy = property[:BASE][:ID][:password_policy]
  rescue NoMethodError
    password_policy = nil
  end

  next if password_policy == nil

  describe file("/etc/login.defs") do
    max_days = password_policy[:max_days]
    min_days = password_policy[:min_days]
    min_length = password_policy[:min_length]
    warn_age = password_policy[:warn_age]

    describe ("パスワード期限（日数）が#{max_days}であること"), :if => max_days != nil do
      its(:content) { should match /^PASS_MAX_DAYS\s+#{max_days}\s*$/ }
    end

    describe ("パスワードの変更不可期間（日数）が#{min_days}であること"), :if => min_days !=nil do
      its(:content) { should match /^PASS_MIN_DAYS\s+#{min_days}\s*$/ }
    end

    describe ("パスワードの最小文字数が#{min_length}であること"), :if => min_length !=nil do
      its(:content) { should match /^PASS_MIN_LEN\s+#{min_length}\s*$/ }
    end

    describe ("パスワード期限切れの警告を#{warn_age}日前からする設定であること"), :if => warn_age !=nil do
      its(:content) { should match /^PASS_WARN_AGE\s+#{warn_age}\s*$/ }
    end
  end
end
