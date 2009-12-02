require 'user'

describe User, 'as a person' do
  before(:each) do
    @user = User.new :name => 'John', :password => 'secret'
  end

  it 'should have name' do
    @user.name.should == 'John'
  end

  it 'should have password' do
    @user.password.should == 'secret'
  end

  it 'should be able to change password' do
    @user.change_password('password')
    @user.password.should == 'password'
  end

  it 'should NOT be able to change user name' do
    @user.should_not respond_to(:name=)
  end
end

describe User, 'as a users storage' do
  before(:each) do
    @user = User.new('John', 'secret')
  end

  after(:each) do
    if User.users.keys.include? 'John'
      User.remove('John')
    end
  end

  it 'should be able to add new users' do
    User.should respond_to(:add)
    User.add(@user)
    User.users.keys.should include('John')
    User.users['John'].should == @user
  end

  it 'should NOT be able to add new user having name which already exists' do
    User.add(@user)  
    new_user = User.new('John', 'password')
    lambda {User.add(new_user)}.should raise_error
  end

  it 'should be able to remove users' do
    User.should respond_to(:remove)
    User.add(@user)
    User.remove('John')
    User.users.keys.should_not include('John')
  end

  it 'should NOT be able to remove non-existing users' do
    lambda {User.remove('NonExistingUser')}.should raise_error
  end

  it 'should be able to access users list' do
    User.should respond_to(:users)
  end

  it 'should be able to change users list' do
    User.should respond_to(:users=)
  end
end
