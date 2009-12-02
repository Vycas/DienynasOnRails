require 'spec_helper'

describe Attendance do
  fixtures :users
  
  before(:each) do
    @teacher = users(:teacher)
    @student = users(:student)
    @course = Course.new(:teacher => @teacher, :title => 'Math')
    @attendance = Attendance.new(:course => @course, :student => @student)
  end

  it 'should have student' do
    @attendance.student.should == @student
  end

  it 'should have course' do
    @attendance.course.should == @course
  end

  it 'should be able to get marks average' do
    @marks << Mark.new(6)
    @marks << Mark.new(10)
    @marks << Mark.new(7)
    @marks.average.should be_close((6+10+7)/3.0, 0.01)
    100.times do
      @marks << Mark.new(rand(10).to_i + 1)
    end
    @marks.average.should be_between(1, 10)
  end

  it 'should be able to get n count' do
    count = rand(10).to_i + 1
    count.times { Mark.new(:attendance => @attendance, :value => 'n').save }
    @attendance.n_count.should == count
  end

  it 'should be able to get p count' do
    count = rand(10).to_i + 1
    count.times { Mark.new(:attendance => @attendance, :value => 'p').save }
    @attendance.p_count.should == count
  end

  it 'should be able to provide marks string' do
    @attendance.should respond_to(:to_s)
    @attendance.to_s.should be_instance_of(String)
  end
end
