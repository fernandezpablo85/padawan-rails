class StudentsController < ApplicationController

  #======Filters========
  before_filter :find_by_id, :except => [:index, :new, :create]
  #=====================
  
  #======Page Cache=====
  caches_page :index, :show
  cache_sweeper :student_sweeper
  #=====================
  
def index
  @students = Student.find :all
end

def show; end
def edit; end

def new
  @student = Student.new
end

def create
  @student = Student.new(params[:student])
  if @student.save 
    redirect_to students_path 
  else
    render :action => 'new', :status => 400
  end
end

def update

  if @student.update_attributes(params[:student])then
    #flash[:notice] = "Student Updated"
    redirect_to students_path
  else
    render :action => 'edit', :status => 400
  end
end

def destroy
  @student.destroy
  #flash[:notice] = "Student deleted"
  redirect_to students_path
end

private
def find_by_id
  @student = Student.find_by_id params[:id]
end

end
