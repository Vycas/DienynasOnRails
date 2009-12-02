class User
  def initialize(name, password)
    @name = name
    @password = password
  end

  attr :name
  attr :password

  def change_password(password)
    @password = password
  end

  def to_s
    "#{@name} - #{self.class}" 
  end

  @users = {}
  class << self
    attr :users, true
  end

  def User.add(user)
    if @users.keys.include? user.name
      raise "User #{user.name} already exists"
    else
      @users[user.name] = user
    end
  end

  def User.remove(username)
    if @users.keys.include? username
      @users.delete(username)
    else
      raise "User #{username} doesn't exist"
    end
  end
end
