require 'spec_helper'
require 'matchers'

describe Teacher do
  fixtures :users
  fixtures :courses

  before(:each) do
    @teacher = users(:ruby_teacher)
    @course = courses(:ruby)
  end

  it 'should be a kind of user' do
    @teacher.should be_kind_of(User)
  end

  it 'should have a list of available commands' do
    @teacher.should respond_to(:commands)
    @teacher.commands.should be_instance_of(Array)
  end

  it 'should be able to access its courses' do
    @teacher.should respond_to(:courses)
  end

  it 'should have a command to add new course' do
    @teacher.should have_command(:add_course)
  end

  it 'should have a command to remove courses' do
    @teacher.should have_command(:remove_course)
  end

  it 'should have a command to list registered courses' do
    @teacher.should have_command(:list_courses)
  end

  it 'should have a command to set default course' do
    @teacher.should have_command(:default_course)
  end

  it 'should have a command to assign student to a course' do
    @teacher.should have_command(:assign_student)
  end

  it 'should have a command to remove student from a course' do
    @teacher.should have_command(:remove_student)
  end

  it 'should have a command to list assigned students' do
    @teacher.should have_command(:list_students)
  end

  it 'should have a command to enter marks' do
    @teacher.should have_command(:enter)
  end

  it 'should be able to add new courses' do
    @teacher.add_course("Math", "Science if numbers", "Monday 8.00")
    @teacher.courses.exists?(:title => "Math").should be_true
    @teacher.remove_course("Math")
  end

  it 'should not be able to add course which already exists' do
    lambda {
      @teacher.add_course("Ruby")
    }.should raise_error
  end

  it 'should be able to remove courses' do
    @teacher.add_course("Math", "Science of numbers", "Monday 8.00")
    @teacher.remove_course("Math")
    @teacher.courses.exists?(:title => "Math").should be_false
  end

  it 'should not be able to remove course which does not exist' do
    lambda {
      @teacher.remove_course('NotExistingCourse')
    }.should raise_error
  end

  it 'should be able to list registered courses' do
    courses = @teacher.list_courses
    @teacher.courses.each { |c| courses.should include(c.to_s) }
  end

  it 'should be able to set default course' do
    @teacher.default_course('Ruby')
  end

  it 'should not be able to set default course for non-existing course' do
    lambda {
      @teacher.default_course('NonExistingCourse')
    }.should raise_error
  end

  it 'should be able to assign student to courses' do
    student = users(:student)
    @teacher.assign_student student.name, 'Ruby'
    @course.reload
    student.reload
    @course.students.exists?(:name => student.name).should be_true
    student.courses.exists?(:title => 'Ruby').should be_true
    Attendance.get(@teacher.name, @course.title, student.name).should_not be_nil
  end

  it 'should be able to remove students from the course' do
    student = users(:student)
    @teacher.assign_student student.name, 'Ruby'
    @teacher.remove_student student.name, 'Ruby'
    @course.students.exists?(:name => student.name).should be_false
    student.courses.exists?(:title => 'Ruby').should be_false
    Attendance.exists?(:student_id => student.id, :course_id => @course.id).should be_false
  end

  it 'should be able to list assigned to courses students and their marks' do
    student = users(:student)
    @teacher.assign_student student.name, 'Ruby'
    @teacher.enter student.name, 9, 'Ruby'
    list = @teacher.list_students 'Ruby'
    a = Attendance.get(@teacher.name, 'Ruby', student.name)
    list.should include("#{student.name} - #{a.marks.all.collect {|v| v.value}}")
  end

  it 'should be able to enter new marks' do
    student = users(:student)
    @teacher.assign_student student.name, 'Ruby'
    @teacher.enter student.name, 9, 'Ruby'
    a = Attendance.get @teacher.name, 'Ruby', student.name
    a.marks[0].value.to_i.should == 9
  end

  it 'should provide help which describes every available command' do
    help = @teacher.help
    help.should be_instance_of String
    @teacher.commands.each { |c| help.should include(c.to_s) }
  end
end
