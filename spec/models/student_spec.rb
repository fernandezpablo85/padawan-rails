require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module StudentHelper

  def create_student(shifts)
    s = Student.new
    s.shifts = shifts
    return s
  end

end

describe Student do

  include StudentHelper

  before do
    @n_shift = mock_model(Shift, :time => 'Night')
    @m_shift = mock_model(Shift, :time => 'Morning')
    @a_shift = mock_model(Shift, :time => 'Afternoon')

    @student = create_student([@a_shift,@n_shift])
    @busy_student = create_student([@a_shift,@n_shift,@m_shift])
  end

  it "should be able to attend to shifts in a different time" do

    @student.can_attend?(@n_shift).should be_false
    @student.can_attend?(@a_shift).should be_false
    @student.can_attend?(@m_shift).should be_true

  end

  it "should not be able to attend to shifts in a same time" do

    @busy_student.can_attend?(@m_shift).should be_false
  
  end

end
