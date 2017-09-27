
describe ("052-Dirctory") do
  begin
    directories = property[:STORAGE][:directory]
  rescue NoMethodError
    directories = nil
  end

  next if directories == nil

  directories.each do |directory|
    path = directory[:path]
    owner_user = directory[:owner_user]
    owner_group = directory[:owner_group]
    permission = directory[:permission]

    describe file("#{path}") do
      describe ("がディレクトリであること") do
        it { should be_directory }
      end

      describe ("のオーナーが#{ owner_user }であること"), :if => owner_user != nil  do
        it { should be_owned_by owner_user }
      end

      describe ("のオーナーグループが#{ owner_group }であること"), :if => owner_group != nil do 
        it { should be_grouped_into owner_group }
      end

      describe ("のパーミッションが#{ permission }であること"), :if => permission != nil do
        it { should be_mode "#{ permission }" }
      end
    end
  end
end
