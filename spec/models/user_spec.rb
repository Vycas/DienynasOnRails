require 'spec_helper'

describe User, 'as a person' do
  before(:each) do
    @valid_attributes = { :name => 'John', :password => 'secret' }
    @user = User.new @valid_attributes
  end

  it 'should have name' do
    @user.name.should == 'John'
  end

  it 'should have password' do
    @user.password.should == 'secret'
  end

  it 'should be able to change password' do
    @user.change_password('password')
    puts @user.password
    @user.password.should == 'password'
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
