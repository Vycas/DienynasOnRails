require 'spec_helper'
require 'matchers'

describe Student do
  fixtures :users

  before(:each) do
    @student = users(:student)
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
    teacher = users(:ruby_teacher)
    teacher.save
    teacher.add_course('Math')
    teacher.add_course('IT')
    teacher.assign_student('Vycas', 'Math')
    teacher.assign_student('Vycas', 'IT')
    teacher.enter('Vycas', '10', 'Math')
    teacher.enter('Vycas', '6', 'Math')
    teacher.enter('Vycas', '5', 'IT')
    table = @student.get
    table.should be_instance_of(String)
    @student.courses.each do |course|
      line = "#{course.title} [#{course.teacher.name}] - #{course.marks.all.collect{|v| v.value + ' '}}\n"
      table.should include(line)
    end
  end

  it 'should be able to get a table of marks (Mocks/Stubs)' do
    teacher = mock()
    teacher.should_receive(:name).and_return('Kaboom')
    mark = mock()
    mark.should_receive(:new).any_number_of_times.and_return { |a| Mark.new(:value => a) }
    marks = mock()
    marks.should_receive(:all).and_return([mark.new(3), mark.new(6), mark.new(9)])
    course = mock()
    course.should_receive(:title).once.and_return('Omega')
    course.should_receive(:teacher).and_return(teacher)
    course.should_receive(:marks).and_return(marks)
    @student.courses.stub!(:all).and_return([course])
    list = @student.get
    list.should include("Omega [Kaboom] - 3 6 9")
  end

  it 'should provide help which describes every available command' do
    help = @student.help
    help.should be_instance_of(String)
    @student.commands.each { |c| help.should include(c.to_s) }
  end
end
