class Attendance < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  has_many :marks
  
  def Attendance.get(teacher, course, student)
    t = Teacher.first :conditions => {:name => teacher}
    raise "Teacher #{teacher} doesn't exist!" if t == nil
    c = t.courses.first :conditions => {:title => course}
    s = Student.first :conditions => {:name => student}
    raise "Student #{student} doesn't exist!" if s == nil
    raise "Course #{course} doesn't exist!" if c == nil
    Attendance.first :conditions => {:student_id => s.id, :course_id => c.id}
  end

  def average
    sum, count = 0, 0
    marks.all.each do |m|
      if (1..10).include? m.value.to_i
        sum += m.value.to_i
        count += 1
      end
    end
    count != 0 ? sum / count.to_f : "N/A"
  end

  def n_count
    count = 0
    marks.all.each { |m| count += 1 if m.value == 'n' }
    count
  end

  def p_count
    count = 0
    marks.all.each { |m| count += 1 if m.value == 'p' }
    count
  end

  def to_s
    out = ''
    marks.all { |m| out << m.value.to_s + ' ' }
    out << "Average: #{average.class == Float ? "%.2f" % average : average} "
    out << "n-count: #{n_count} "
    out << "p-count: #{p_count}"
  end
end
