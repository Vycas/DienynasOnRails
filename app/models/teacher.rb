require 'user'
require 'student'
require 'course'
require 'attendance'

class Teacher < User
  has_many :courses
  has_many :attendances, :through => :course

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

  def add_course(title, description=nil, time=nil)
    if courses.exists? :title => title
      raise "Course #{title} already exists."
    else
      c = Course.new :title => title, :description => description, :time => time, :teacher => self
      c.save
    end
  end

  def remove_course(title)
    c = courses.first :conditions => {:title => title}
    raise "Course #{title} doesn't exist." if c == nil
    c.destroy
  end

  def list_courses
    out = ""
    courses.all.each { |c| out << c.to_s + "\n" }
    out
  end

  def default_course(title)
    raise "Course #{title} doesn't exist." unless courses.exists? :title => title
    @current_course = title
  end

  def assign_student(student, course=@current_course)
    raise "Student #{student} doesn't exist." unless Student.exists? :name => student
    raise "Course #{course} doesn't exist." unless courses.exists? :title => course
    c = courses.first :conditions => {:title => course}
    s = Student.first :conditions => {:name => student}
    a = Attendance.new :course => c, :student => s
    a.save
  end

  def remove_student(student, course=@current_course)
    raise "Student #{student} doesn't exist." unless Student.exists? :name => student
    raise "Course #{course} doesn't exist." unless courses.exists? :title => course
    c = courses.first :conditions => {:title => course}
    raise "#{student} is not listening this course." unless c.students.exists? :name => student
    s = c.students.first :conditions => {:name => student}
    a = c.attendances.first :conditions => {:student_id => s.id}
    a.destroy
  end

  def list_students(course=@current_course)
    raise "Course #{course} doesn't exist." unless courses.exists? :title => course
    out = "Course #{course} is listened by:\n"
    courses.first(courses.first(:conditions => {:title => course})).attendances do
      |a| out << "#{a.student.name} - #{a.marks}\n"
    end
    out
  end

  def enter(student, mark, course=@current_course)
    a = Attendance.get(course, student)
    raise "#{student} is not listening this course." if a == nil
    m = Mark.new(:value => mark, :attendance => a)
    m.save
  end
end
