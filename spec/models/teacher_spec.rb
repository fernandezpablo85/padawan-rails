require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module TeacherHelper
  def sample_shifts
    shifts = []
    shifts << mock_model(Shift, :time => "Afternoon")
    shifts << mock_model(Shift, :time => "Night")
    shifts << mock_model(Shift, :time => "Afternoon")
    shifts << mock_model(Shift, :time => "Night")
  end
end

describe Teacher do

  include TeacherHelper

  before do
    @teacher = Teacher.new
  end

  it "should be available for a shift with a different time" do
    @teacher.stub!(:busy_times).and_return(["Afternoon","Night"])
    @teacher.is_available_for?("Afternoon").should be_false  
  end

  it "should not be available for an already assigned time" do
    @teacher.stub!(:busy_times).and_return(["Afternoon","Night"])
    @teacher.is_available_for?("Morning").should be_true
  end

  it "should return the occupied times without repetition" do
    @teacher.stub!(:shifts).and_return(sample_shifts)
    @teacher.busy_times.should eql(["Afternoon","Night"])
  end

end

describe Teacher, ".available_for(time)" do

  it "should return teachers that do not contain that time" do

    teachers = Teacher.available_for("Night")

    teachers.each do |teacher|
      teacher.is_available_for?("Night").should be_true
    end

  end

end
