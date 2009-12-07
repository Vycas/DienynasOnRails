require 'spec_helper'

describe Course do
  fixtures :courses
  fixtures :users

  before(:each) do
    @course = courses(:ruby)
  end

  it 'should have title' do
    @course.title.should == 'Ruby'
  end

  it 'should have description' do
    @course.description.should == 'Programming language'
  end

  it 'should have time' do
    @course.time.should == 'Monday 12.00'
  end

  it 'should have assigned teacher' do
    @course.teacher.should == Teacher.find_by_name('Saulius')
  end

  it 'should be able to access student marks' do
    @course.should respond_to(:marks)
  end

  it 'should be able to get string representation in format "title - description [time]"' do
    str = @course.to_s
    str.should match("(.+) - (.*) \\[(.*)\\]")
  end
end
