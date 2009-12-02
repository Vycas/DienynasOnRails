require 'teacher'
require 'user'
require 'course'
require 'matchers'

describe Teacher do
  before(:each) do
    @teacher = Teacher.new('Teacher', 'password')
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
    @teacher.courses.should be_instance_of(Hash)
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
    @teacher.add_course("Math", "Science of numbers", "Monday 8.00")
    @teacher.courses.keys.should include("Math")
  end

  it 'should not be able to add course which already exists' do
    @teacher.add_course("Math")
    lambda {
      @teacher.add_course("Math")
    }.should raise_error
  end

  it 'should be able to remove courses' do
    @teacher.add_course("Math", "Science of numbers", "Monday 8.00")
    @teacher.remove_course("Math")
    @teacher.courses.should_not include("Math")
  end

  it 'should not be able to remove course which does not exist' do
    lambda {
      @teacher.remove_course('NotExistingCourse')
    }.should raise_error
  end

  it 'should be able to list registered courses' do
    courses = @teacher.list_courses
    @teacher.courses.each { |c| courses.should include(c) }
  end

  it 'should be able to set default course' do
    @teacher.add_course('Math')
    @teacher.default_course('Math')
  end

  it 'should not be able to set default course for non-existing course' do
    lambda {
      @teacher.default_course('NonExistingCourse')
    }.should raise_error
  end

  it 'should be able to assign student to courses' do
    student = Student.new('John', 'password')
    User.add(student)
    @teacher.add_course('Math')
    @teacher.assign_student('John', 'Math')
    @teacher.courses.keys.should include('Math')
    @teacher.courses['Math'].marks.keys.should include('John')
    User.users['John'].marks.keys.should include('Math')
    User.remove('John')
  end

  it 'should be able to remove students from the course' do
    student = Student.new('John', 'password')
    User.add(student)
    @teacher.add_course('Math')
    @teacher.assign_student('John', 'Math')
    @teacher.remove_student('John', 'Math')
    @teacher.courses.keys.should include('Math')
    @teacher.courses['Math'].marks.keys.should_not include('John')
    User.users['John'].marks.keys.should_not include('Math')
    User.remove('John')
  end

  it 'should be able to list assigned to courses students and their marks' do
    student = Student.new('John', 'password')
    User.add(student)
    @teacher.add_course('Math')
    @teacher.assign_student('John', 'Math')
    @teacher.enter('John', 9, 'Math')
    @teacher.enter('John', 6, 'Math')
    @teacher.enter('John', 4, 'Math')
    list = @teacher.list_students('Math')
    list.should include("John - #{@teacher.courses['Math'].marks['John']}")
    User.remove('John')
  end

  it 'should be able to enter new marks' do
    student = Student.new('John', 'password')
    User.add(student)
    @teacher.add_course('Math')
    @teacher.assign_student('John', 'Math')
    @teacher.enter('John', 9, 'Math')
    @teacher.courses['Math'].marks['John'][0].value.should == 9
    User.users['John'].marks['Math'][0].value.should == 9
    User.remove('John')
  end

  it 'should provide help which describes every available command' do
    help = @teacher.help
    help.should be_instance_of(String)
    @teacher.commands.each { |c| help.should include(c.to_s) }
  end
end
