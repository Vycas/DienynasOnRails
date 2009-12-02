class Course
  def initialize(teacher, title, description=nil, time=nil)
    @teacher = teacher
    @title = title
    @description = description
    @time = time
    @marks = {}
  end

  attr_reader :title, :description, :time, :teacher, :marks

  def to_s
    "#{@title} - #{@description} [#{@time}]"
  end
end
