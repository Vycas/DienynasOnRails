require 'spec_helper'

describe Attendance do
  fixtures :users
  
  before(:each) do
    @teacher = users(:ruby_teacher)
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
    Mark.new(:value => 6, :attendance => @attendance).save
    Mark.new(:value => 10, :attendance => @attendance).save
    Mark.new(:value => 7, :attendance => @attendance).save
    @attendance.average.should be_close(7.66, 0.01)
    100.times do
      Mark.new(:value => rand(10).to_i + 1, :attendance => @attendance).save
    end
    @attendance.average.should be_between(1, 10)
  end

  it 'should be able to get n count' do
    count = rand(10).to_i + 1
    count.times { Mark.new(:attendance => @attendance, :value => 'n').save }
    @attendance.reload
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
  
  it 'should be able to get attendance with correct parameters' do
    student = Student.new(:name => 'JayJay')
    student.save
    teacher = Teacher.new(:name => 'Kaboom')
    teacher.save
    course = Course.new(:teacher => teacher, :title => 'Bla')
    course.save
    teacher.assign_student('JayJay', 'Bla')
    Student.should_receive(:first).with(hash_including(:conditions => {:name => 'JayJay'})).and_return(student)
    Teacher.should_receive(:first).with(hash_including(:conditions => {:name => 'Kaboom'})).and_return(teacher)
    Attendance.get(teacher.name, course.title, student.name).should_not be_nil
  end
end
