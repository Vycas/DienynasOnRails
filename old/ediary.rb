#!/usr/bin/env ruby

require 'user'
require 'admin'

class EDiary
  def initialize
    User.users['admin'] = Admin.new('admin', 'boom')
    User.users['vycas'] = Student.new('vycas', 'vycas')
    User.users['ruby'] = Teacher.new('ruby', 'ruby')
  end

  def welcome
    puts '-' * 40
    puts 'Welcome to electronic diary.'
    puts 'Version: 1.0'
    puts '-' * 40
  end

  def login
    load_state

    print 'Login: '
    login = gets.chomp
    print 'Password: '
    password = gets.chomp

    if user = User.users[login]
      if user.password == password
        go(user)
        save_state
      else
        puts 'Incorrect password!'
      end
    else
      puts 'No such user!'
    end
  end

  def go(user)
    puts 'You have logged in as ' + user.class.to_s
    puts 'Type "disconnect" to quit. Type "help" to get info about commands.'
    while true
      print '> '
      cmd = gets.chomp
      break if cmd == 'disconnect'
      parts = cmd.split
      if user.commands.include?(parts[0].to_sym)
        begin
          code = 'user.' + parts[0]
          code += " '#{parts[1]}'" if parts[1]
          parts[2..-1].each { |p| code += ", '#{p}'" } if parts[2]
          out = eval(code)
          puts out if out.class == String
        rescue => exc
          puts "Error: #{exc.message}"
        end
      else
        puts 'Incorrect command!'
      end
    end
    puts 'Disconnected'
  end

  private

  Storage = "storage.data"

  def load_state
    if File.exists? Storage
      f = File.open(Storage, 'r')
      d = f.read(File.size(Storage))
      User.users = Marshal.load(d)
      f.close
    end
  end

  def save_state
    f = File.new(Storage, 'w')
    d = Marshal.dump(User.users)
    f.write(d)
    f.close
  end
end

diary = EDiary.new
diary.welcome
diary.login
