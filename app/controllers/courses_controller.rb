class CoursesController < ApplicationController

  #======Filters========
  before_filter :find_by_id, :except => [:index, :new, :create, :show]
  #=====================
  
  #======Page Cache=====
  caches_page :index, :show
  cache_sweeper :course_sweeper
  #=====================

def index
  @courses = Course.find :all
end

def show
  @course = Course.find(params[:id], :include => :shifts)
end

def new
  @course = Course.new
end

def create
  @course = Course.new(params[:course])
  if @course.save then
    #flash[:notice] = 'Course Created'
    redirect_to :action => 'index'
  else
    render :action => 'new', :status => 400
  end
end

def edit
end

def update
  @course.update_attributes(params[:course])

  if @course.save then
    #flash[:notice] = "Course Updated"
    redirect_to :action => 'index'
  else
    render :action => 'edit', :status => 400
  end
end

def destroy
  @course.destroy
  #flash[:notice] = "Course deleted"
  redirect_to :action => 'index'
end

private 
def find_by_id
  @course = Course.find params[:id]
end
end
