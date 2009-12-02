require 'spec_helper'

describe Mark do
  before(:each) do
    @valid_attributes = {
      :value => "value for value",
      :date => "value for date",
      :student => ,
      :course => 
    }
  end

  it "should create a new instance given valid attributes" do
    Mark.create!(@valid_attributes)
  end
end
