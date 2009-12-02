class User < ActiveRecord::Base
  def change_password(psw)
    self.password = psw
    self.save
  end 

  def to_s
    "#{name} - #{self.class}" 
  end 

  def find_by_name(name)
    User.find(:first, :conditions => "name = #{name}")
  end

  def remove_by_name(name)
    u = find_by_name(name)
    u.remove
  end
end
