class Mark < ActiveRecord::Base
  belongs_to :attendance
  
  def validate
    if not [(1..10).to_a, 'p', 'n'].flatten.include? value
      raise 'value must be in range 1-10 or string "n" or "p".'
    end
    
    if date == nil
      date = Date.today
    end
  end
end
