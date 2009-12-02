class User < ActiveRecord::Base

  def change_password(psw)
    self.password = psw
    self.save
  end 

  def to_s
    "#{name} - #{self.class}" 
  end 

  def User.find_by_name(name)
    User.find(:first, :conditions => "name = '#{name}'")
  end

  def User.remove_by_name(name)
    u = find_by_name(name)
    u.destroy if u != nil
  end
end
