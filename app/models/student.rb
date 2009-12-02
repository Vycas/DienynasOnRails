require 'user'

class Student < User
  has_many :attendance
  has_many :marks, :through => :attendance
  has_many :courses, :through => :attendance

  def commands
    [:help, :change_password, :get]
  end

  def help
    out =  "Available commands:\n"
    out << "  help - to show this help\n"
    out << "  change_password <password> - to change your password\n"
    out << "  get - to get a table of marks\n"
  end

  def get
    out = ''
    cources.all do |course|
      out << "#{course.title} [#{course.teacher.name}] - #{course.marks.to_s}\n"
    end
    out
  end
end
