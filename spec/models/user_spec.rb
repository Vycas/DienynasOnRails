require 'spec_helper'

describe User, 'as a person' do
  fixtures :users

  before(:each) do
    @valid_attributes = { :name => 'SomeUser', :password => 'SomePassword' }
    @user = users(:user)
  end

  it 'should have name' do
    @user.name.should == 'User'
  end

  it 'should have password' do
    @user.password.should == 'password'
  end

  it 'should be able to change password' do
    @user.change_password('newPassword')
    @user.password.should == 'newPassword'
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
