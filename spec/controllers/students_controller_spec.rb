require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StudentsController do
  before do
    @student = stub_model(Student)
    Student.stub!(:find).and_return(@student)
    Student.stub!(:new).and_return(@student)  
  end

  describe "GET /students" do

    it "Should fetch all students" do

      Student.should_receive(:find).with(:all).once

      get :index
    end

    it "Should render student list template" do

      get :index

      response.should be_success
      response.should render_template('index')
    end

  end

  describe "GET /student/:student_id" do

    it "Should fetch one student by ID" do

      Student.should_receive(:find)
          
      get :show, :id => 1
    end

    it "Should render student details template" do
      
      get :show, :id => 1

      response.should be_success
      response.should render_template('show')
    end

  end

  describe "GET /student/:student_id" do

     it "Should fetch one student by ID" do

      Student.should_receive(:find)
          
      get :edit, :id => 1
    end

    it "Should render student details template" do
      
      get :edit, :id => 1

      response.should be_success
      response.should render_template('edit')
    end

  end

  describe "GET /students/new [Good Input]" do

    it "Should render student creation view" do

      get :new
    
      response.should be_success
      response.should render_template('new')
    end

  end

  describe "POST /students [Good Input]" do

    it "Should create a new student and render students list" do
      
      @student.should_receive(:save).and_return(true)
      
      post :create    
      
      response.should redirect_to(students_url)
    end
    
  end

  describe "POST /students [Bad Input]" do
    
    it "Should not create a student and render the new template again" do
      
      @student.should_receive(:save).and_return(false)

      post :create

      response.should_not be_success
      response.should render_template('new')
    end
    
  end

  describe "PUT /student/:student_id [Good Input]" do
    
    it "Should update the student and render the student list" do
      @student.should_receive(:save).and_return(true)
        
      put :update, :id => 1
        
      response.should redirect_to(students_url)
    end
  end

  describe "PUT /student/:student_id [Bad Input]" do

    it "Should not update the student and render the template again" do
      @student.should_receive(:save).and_return(false)

      put :update, :id => 1

      response.should_not be_success
      response.should render_template('edit')
    end
  end

  describe "DELETE /student/:student_id" do

    it "Should delete the student and redirect to students list" do
      @student.should_receive(:destroy)

      delete :destroy, :id => 1

      response.should redirect_to(students_url)
    end
  end
end
