require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :time => "value for time",
      :teacher => 
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
end
