require 'date'

class Mark
  def initialize(value, date=Date.today)
    if not [(1..10).to_a, 'p', 'n'].flatten.include? value
      raise 'Mark must be in range 1-10 or string "n" or "p".'
    end
    @value = value
    @date = date
  end

  attr :value, true
  attr :date, true

  def to_s
    "#{@value} [#{@date}]"
  end
end


class Marks < Array
  def initialize(course, student)
    @course = course
    @student = student
  end

  attr :course, true
  attr :student, true

  def average
    sum, count = 0, 0
    self.each do |m|
      if m.class == Mark and m.value.kind_of? Integer
        sum += m.value
        count += 1
      end
    end
    count != 0 ? sum / count.to_f : "N/A"
  end

  def n_count
    count = 0
    self.each { |m| count += 1 if m.value == 'n' }
    count
  end

  def p_count
    size
   # count = 0
   # self.each { |m| count += 1 if m.value == 'p' }
   # count
  end

  def to_s
    out = ''
    self.each { |m| out << m.value.to_s + ' ' }
    out << "Average: #{average.class == Float ? "%.2f" % average : average} "
    out << "n-count: #{n_count} "
    out << "p-count: #{p_count}"
  end
end
