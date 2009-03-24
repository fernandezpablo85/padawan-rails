require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InscriptionsController do

before do
  @student = stub_model(Student)
  @shift = stub_model(Shift)
  @inscription = stub_model(Inscription)
  Shift.stub!(:find).and_return(@shift)
  Student.stub!(:find).and_return(@student)
  Inscription.stub!(:find).and_return(@inscription)
end

describe "GET /students/:student_id/inscriptions" do

  it "Should populate @shifts with available shifts" do
    Shift.should_receive(:find_availables_for).and_return([])

    get "index", :student_id => 1

    assigns[:shifts].should_not be_nil
    response.should be_success
  end

end

describe "POST /students/:student_id/inscribe/:shift_id" do

  it "Should add the inscription to the student" do
    @student.should_receive(:save)
    
    post "inscribe",:student_id => 1, :shift_id => 1

    @student.inscriptions.size > 0
    @student.should_not be_new_record
  end

end

describe "DELETE /students/:student_id/inscriptions/:id" do

  it "Should delete the inscription" do
    @student.should_receive(:save)
    @inscription.should_receive(:destroy)

    delete "destroy", :student_id => @student, :id => @inscription

    @student.inscriptions.size == 0
  end
end 

end
