require 'user'
require 'course'
require 'mark'

class Teacher < User
  def initialize(name, password)
    super(name, password)
    @courses = {}
    @current_course = nil
  end

  def commands
    [:help, :change_password, :add_course, :remove_course, :list_courses,
     :assign_student, :remove_student, :list_students, :default_course, :enter]
  end

  def help
    out =  "Available commands:\n"
    out << "  help - to show this help\n"
    out << "  add_course <title> [<description>] [<time>] - to add new course\n"
    out << "  remove_course <title> - to remove existing course\n"
    out << "  list_courses - to list existing courses\n"
    out << "  change_password <password> - to change your password\n"
    out << "  default_course <course> - to set default working course\n"
    out << "  assign_student <student> [<course>] - to assign student to a course\n"
    out << "  remove_student <student> [<course>] - to remove student from a course\n"
    out << "  list_students [<course>] - to list students assigned to a course\n"
    out << "  enter <student> <mark> [<course>] - to enter new mark\n"
  end

  attr :courses

  def add_course(title, description=nil, time=nil)
    if @courses.keys.include? title
      raise "Course #{title} already exists."
    else
      @courses[title] = Course.new(self, title, description, time)
    end
  end

  def remove_course(title)
    if @courses.keys.include? title
      @courses.delete title
    else
      raise "Course #{title} doesn't exist."
    end
  end

  def list_courses
    out = ""
    @courses.values.each { |c| out << c.to_s + "\n" }
    out
  end

  def default_course(title)
    if @courses.keys.include? title
      @current_course = title
    else
      raise "Course #{title} doesn't exist."
    end
  end

  def assign_student(student, course=@current_course)
    raise "Student #{student} doesn't exist." if not User.users.keys.include? student
    raise "#{student} is not a student." if User.users[student].class != Student
    raise "Course #{course} doesn't exist." if not @courses.keys.include? course
    marks = Marks.new(@courses[course], User.users[student])
    @courses[course].marks[student] = marks
    User.users[student].marks[course] = marks
  end

  def remove_student(student, course=@current_course)
    raise "Student #{student} doesn't exist." if not User.users.keys.include? student
    raise "Course #{course} doesn't exist." if not @courses.keys.include? course
    raise "#{student} is not listening this course." if not @courses[course].marks.include? student
    @courses[course].marks.delete student
    User.users[student].marks.delete course
  end

  def list_students(course=@current_course)
    raise "Course #{course} doesn't exist." if not @courses.keys.include? course
    out = "Course #{course} is listened by:\n"
    @courses[course].marks.keys.each { |s| out << "#{s} - #{@courses[course].marks[s]}\n" }
    out
  end

  def enter(student, mark, course=@current_course)
    raise "Student #{student} doesn't exist." if not User.users.keys.include? student
    raise "Course #{course} doesn't exist." if not @courses.keys.include? course
    raise "#{student} is not listening this course." if not @courses[course].marks.include? student
    mark = mark.to_i if mark.to_i != 0
    m = Mark.new(mark)
    @courses[course].marks[student] << m
  end
end
