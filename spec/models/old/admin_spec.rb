require 'admin'
require 'user'
require 'student'
require 'matchers'

describe Admin, '(System administrator)' do
  before(:each) do
    @admin = Admin.new('Administrator', 'password')
  end

  it 'should be a kind of user' do
    @admin.should be_kind_of(User)
  end

  it 'should have a list of available commands' do
    @admin.should respond_to(:commands)
    @admin.commands.should be_instance_of([].class)
  end

  it 'should have help command' do
    @admin.should have_command(:help)
  end

  it 'should have command for adding new users' do
    @admin.should have_command(:add_student)
  end

  it 'should have command for adding new teacher' do
    @admin.should have_command(:add_teacher)
  end

  it 'should have command for removing users' do
    @admin.should have_command(:remove_user)
  end

  it 'should have command for changing other users passwords' do
    @admin.should have_command(:change_user_password)
  end

  it 'should have command for listing registered users' do
    @admin.should have_command(:list_users)
  end

  it 'should be able to add new student' do
    @admin.add_student('Student', 'password')
    User.users.keys.should include('Student')
    User.users['Student'].should be_instance_of(Student)
  end

  it 'should be able to add new teacher' do
    @admin.add_teacher('Teacher', 'password')
    User.users.keys.should include('Teacher')
    User.users['Teacher'].should be_instance_of(Teacher)
  end

  it 'should be able to remove users' do
    user = User.new('User', 'password')
    User.add(user)
    @admin.remove_user('User')
    User.users.values.should_not include(user)
  end

  it 'should be able to change other users passwords' do
    user = User.new('User', 'password')
    User.add(user)
    @admin.change_user_password('User', 'newPassword')
    user.password.should == 'newPassword'
  end

  it 'should not be able to change password for non-existing user' do
    lambda { 
      @admin.change_user_password('Non-existing-user', 'newPassword') 
    }.should raise_error
  end

  it 'should be able to list all registered users' do
    list = @admin.list_users
    list.should be_instance_of(String)
    User.users.values.each { |u| list.should include(u.name) }
  end

  it 'should provide help which describes every available command' do
    help = @admin.help
    help.should be_instance_of(String)
    @admin.commands.each { |c| help.should include(c.to_s) }
  end

  after(:each) do
    if User.users.keys.include?('Teacher')
      User.remove('Teacher')
    end
    if User.users.keys.include?('Student')
      User.remove('Student')
    end
  end
end
