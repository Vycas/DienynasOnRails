class Course < ActiveRecord::Base
  belongs_to :teacher
  has_many :attendances
  has_many :students, :through => :attendances
  has_many :marks, :through => :attendances

  def to_s
    "#{title} - #{description} [#{time}]"
  end
end
