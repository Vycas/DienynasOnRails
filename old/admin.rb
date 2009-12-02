require 'user'
require 'student'
require 'teacher'

class Admin < User
  def commands
    [:help, :add_student, :add_teacher, :remove_user, 
     :change_password, :change_user_password, :list_users]
  end

  def help
    out =  "Available commands:\n"
    out << "  help - to show this help\n"
    out << "  add_student <username> <password> - to add new student\n"
    out << "  add_teacher <username> <password> - to add new teacher\n"
    out << "  remove_user <username> - to remove user\n"
    out << "  change_user_password <username> <password> - to change user's password\n"
    out << "  change_password <password> - to change your password\n"
    out << "  list_users - to get list of users\n"
  end

  def add_student(name, password)
    student = Student.new(name, password)
    User.add student
  end

  def add_teacher(name, password)
    teacher = Teacher.new(name, password)
    User.add teacher
  end

  def remove_user(username)
    User.remove username
  end

  def change_user_password(username, password)
    if not User.users.keys.include? username
      raise "User #{username} doesn't exist"
    end
    User.users[username].change_password(password)
  end

  def list_users
    out = ""
    User.users.values.each { |u| out << u.to_s + "\n" }
    out
  end
end
