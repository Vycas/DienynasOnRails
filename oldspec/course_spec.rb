require 'course'
require 'teacher'
require 'student'

describe Course do
  before(:each) do
    @teacher = Teacher.new('Teacher', 'password')
    @course = Course.new(@teacher, 'Math', 'Science of numbers', 'Monday 8.00')
  end

  it 'should have title' do
    @course.title.should == 'Math'
  end

  it 'should have description' do
    @course.description.should == 'Science of numbers'
  end

  it 'should have time' do
    @course.time.should == 'Monday 8.00'
  end

  it 'should have assigned teacher' do
    @course.teacher.should == @teacher
  end

  it 'should be able to access student marks' do
    @course.should respond_to(:marks)
    @course.marks.should be_instance_of(Hash)
  end

  it 'should be able to get string representation in format "title - description [time]"' do
    str = @course.to_s
    str.should match("(.+) - (.*) \\[(.*)\\]")
  end
end
