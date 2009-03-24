require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CoursesController do

  before do
    @course = Course.new
    Course.stub!(:find).and_return(@course)
    Course.stub!(:new).and_return(@course)
  end

describe "GET /courses" do

  it "should fetch all courses" do

    Course.should_receive(:find).with(:all).once

    get :index        
  end

  it "should redirect to Course index page" do

    get :index

    response.should be_success
    response.should render_template("index")
  end
end

describe "GET /courses/:course_id" do

  it "should fetch a course from DB" do

    Course.should_receive(:find).once

    get :show, :id => 1
  end

  it "should redirect to Course details page" do

    get :show, :id => 1

    response.should be_success
    response.should render_template("show")
  end
end

describe "GET /courses/new" do

  it "should create a fresh course for user input" do

    get :new

    assigns[:course].should_not be_nil
  end

  it "should redirect to Course creation page" do

    get :new

    response.should be_success
    response.should render_template("new")
  end

end

describe "POST /courses [Good Input]" do

  it "should render Courses index page after creation" do

    @course.stub!(:valid?).and_return(true)

    post :create

    assigns[:course].should_not be_new_record
    response.should be_redirect
    response.should redirect_to(courses_url)
  end

end

describe "POST /courses [Bad Input]" do

  it "should render the Course creation page for the user to correct the errors" do

    @course.stub!(:valid?).and_return(false)

    post :create

    assigns[:course].should be_new_record
    response.should_not be_success
    response.should render_template('new')
  end

end

describe "PUT /courses/:course_id [Good Input]" do

  it "should render Course index page after update" do

    @course.stub!(:valid?).and_return(true)

    put :update, :id =>1
  
    response.should be_redirect
    response.should redirect_to(courses_path)
  end

end

describe "PUT /courses/:course_id [Bad Input]" do

  it "should render Course edit page for the user to correct the errors" do

    @course.stub!(:valid?).and_return(false)

    put :update, :id => 1

    response.should_not be_success
    response.should render_template('edit')
  end

end

describe "DELETE /courses/:course_id" do

  it "should delete the given course and render the Course list" do
    
    delete :destroy, :id => 1
    
    response.should be_redirect
    response.should redirect_to(courses_path)
  end

end

end
