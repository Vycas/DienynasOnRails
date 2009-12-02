class Mark < ActiveRecord::Base
  belongs_to :attendance
  
  def validate
    if not [(1..10).to_a, 'p', 'n'].flatten.include? value
      errors.add 'value', 'must be in range 1-10 or string "n" or "p".'
    end
    if value == 'p'
      value = 101
    end
    if value == 'n'
      value = 100
    end
  end
end
