require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ShiftHelper

  def some_shifts
    ret = []
    ret << Shift.new(:time => "Afternoon")
    ret << Shift.new(:time => "Night")
    return ret
  end  

end

describe Shift,".find_availables_for(student)" do
  
  include ShiftHelper

  before do
    @student = mock_model(Student)
    Shift.stub!(:find).and_return(some_shifts)
  end

  it "should return an array of available shifts" do

    @student.stub!(:can_attend?).and_return(true)

    shifts_found = Shift.find_availables_for(@student)

    shifts_found.should_not be_empty
    
  end

  it "should return an empty array if the user has 3 types of shifts_found" do

    @student.stub!(:can_attend?).and_return(false)
    
    shifts_found = Shift.find_availables_for(@student)

    shifts_found.should be_empty
    
  end

end
