require 'student'
require 'teacher'
require 'user'
require 'matchers'

describe Student do
  before(:each) do
    @student = Student.new('Student', 'password')
  end

  it 'should be a kind of user' do
    @student.should be_kind_of(User)
  end

  it 'should have a list of available commands' do
    @student.should respond_to(:commands)
    @student.commands.should be_instance_of(Array)
  end

  it 'should be able from outside to access and change its marks' do
    @student.should respond_to(:marks)
    @student.should respond_to(:marks=)
  end

  it 'should have a command to get a table of marks' do
    @student.should have_command(:get)
  end

  it 'should be able to get a table of marks' do
    teacher = User.add(Teacher.new('Teacher', 'password'))
    User.add(@student)
    teacher.add_course('Math')
    teacher.add_course('IT')
    teacher.assign_student('Student', 'Math')
    teacher.assign_student('Student', 'IT')
    teacher.enter('Student', '10', 'Math')
    teacher.enter('Student', '6', 'Math')
    teacher.enter('Student', '5', 'IT')
    table = @student.get
    table.should be_instance_of(String)
    @student.marks.each_pair do |course, marks|
      line = "#{course} [#{marks.course.teacher.name}] - #{marks.to_s}\n"
      table.should include(line)
    end
    User.remove('Teacher')
    User.remove('Student')
  end

  it 'should provide help which describes every available command' do
    help = @student.help
    help.should be_instance_of(String)
    @student.commands.each { |c| help.should include(c.to_s) }
  end
end
