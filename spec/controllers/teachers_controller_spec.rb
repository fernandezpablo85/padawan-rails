require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeachersController do

  before do
    @teacher = stub_model(Teacher)
    Teacher.stub!(:find).and_return(@teacher)
    Teacher.stub!(:new).and_return(@teacher)  
  end

  describe "GET /teachers" do

    it "Should fetch all teachers" do

      Teacher.should_receive(:find).with(:all).once

      get :index
    end

    it "Should render teacher list template" do

      get :index

      response.should be_success
      response.should render_template('index')
    end

  end

  describe "GET /teacher/:teacher_id" do

    it "Should fetch one teacher by ID" do

      Teacher.should_receive(:find)
          
      get :show, :id => 1
    end

    it "Should render teacher details template" do
      
      get :show, :id => 1

      response.should be_success
      response.should render_template('show')
    end

  end

  describe "GET /teacher/:teacher_id" do

     it "Should fetch one teacher by ID" do

      Teacher.should_receive(:find)
          
      get :edit, :id => 1
    end

    it "Should render teacher details template" do
      
      get :edit, :id => 1

      response.should be_success
      response.should render_template('edit')
    end

  end

  describe "GET /teachers/new [Good Input]" do

    it "Should render teacher creation view" do

      get :new
    
      response.should be_success
      response.should render_template('new')
    end

  end

  describe "POST /teachers [Good Input]" do

    it "Should create a new teacher and render teachers list" do
      
      @teacher.should_receive(:save).and_return(true)
      
      post :create    
      
      response.should redirect_to(teachers_url)
    end
    
  end

  describe "POST /teachers [Bad Input]" do
    
    it "Should not create a teacher and render the new template again" do
      
      @teacher.should_receive(:save).and_return(false)

      post :create

      response.should_not be_success
      response.should render_template('new')
    end
    
  end

  describe "PUT /teacher/:teacher_id [Good Input]" do
    
    it "Should update the teacher and render the teacher list" do
      @teacher.should_receive(:save).and_return(true)
        
      put :update, :id => 1
        
      response.should redirect_to(teachers_url)
    end
  end

  describe "PUT /teacher/:teacher_id [Bad Input]" do

    it "Should not update the teacher and render the template again" do
      @teacher.should_receive(:save).and_return(false)

      put :update, :id => 1

      response.should_not be_success
      response.should render_template('edit')
    end
  end

  describe "DELETE /teacher/:teacher_id" do

    it "Should delete the teacher and redirect to teachers list" do
      @teacher.should_receive(:has_shifts?).and_return(false)
      @teacher.should_receive(:destroy)

      delete :destroy, :id => 1

      response.should redirect_to(teachers_url)
    end

    it "Should fail and inform errors if the teacher has courses assigned" do
      @teacher.should_receive(:has_shifts?).and_return(true)
      @teacher.should_not_receive(:destroy)

      delete :destroy, :id =>1

      @teacher.should have(1).error
      response.should_not be_success
      response.should render_template('show')
    end  
  end
end
