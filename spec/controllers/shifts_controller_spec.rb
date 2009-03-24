require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ShiftsController do

  before do
    @shift = Shift.new
    @shift.stub!(:valid?).and_return(true)
    @shift.id = 1

    @teacher = Teacher.new
    @teacher.stub!(:valid?).and_return(true)
    @teacher.id = 1

    @course = Course.new 
    @course.stub!(:valid?).and_return(true)
    @course.id = 1

    Shift.stub!(:new).and_return(@shift)
    Shift.stub!(:find).and_return(@shift)
    Course.stub!(:find).and_return(@course)
  end

  describe "GET /shift/new" do

    it "Should create a fresh shift and render the new template" do

      Shift.should_receive(:new)

      get :new ,:course_id => @course

      response.should be_success
      response.should render_template('new')
    end
  end

  describe "POST /shifts [Good Input]" do
    
    it "Should create a valid new shift and redirect to the course path" do

      @shift.should_receive(:valid?)

      post :create, :course_id => @course

      @shift.course.should_not be_nil
      response.should redirect_to(course_path(@course))      
    end

  end

  describe "POST /shifts [Bad Input]" do

    it "Should not create a new shift and render the shift form again" do
  
      @shift.should_receive(:valid?).and_return(false)

      post :create, :course_id => @course

      response.should_not be_success
      response.should render_template('new')
    end

  end

  describe "DELETE /shift/:shift_id" do

    it "Should delete the shift and redirect to the course path" do

      @shift.should_receive(:destroy)

      delete :destroy, :course_id => @course, :id => @shift

      response.should redirect_to(course_path(@course))
    end

  end

  describe "POST /shifts/list_teachers" do

    it "Should find all available teachers for the shift" do
      
      Teacher.should_receive(:available_for)
    
      post :list_teachers, :course_id => @course, :shift_id => @shift
        
      response.should render_template('list_teachers')
    end

  end

  describe "POST /shifts/add_teacher" do

    it "Should update the shift with the new teacher" do

      Teacher.should_receive(:find_by_name).and_return(@teacher)
      @shift.stub!(:valid?).and_return(true)

      post :add_teacher, :course_id => @course, :shift_id => @shift
  
      @shift.teacher.should_not be_nil
      response.should redirect_to(course_path(@course))
    end
    
  end

end

