class TeachersController < ApplicationController

  #======Filters========
  before_filter :find_by_id, :except => [:index, :new, :create]
  #=====================
  
  #======Page Cache=====
  caches_page :index, :show
  cache_sweeper :teacher_sweeper
  #=====================

def index
  @teachers = Teacher.find :all
end

def show; end
def edit; end

def new
  @teacher = Teacher.new
end

def create
  @teacher = Teacher.new(params[:teacher])
  
  if @teacher.save then
    #flash[:notice] = "Teacher Saved"
    redirect_to :action => 'index'
  else
    render :action => 'new', :status => 400
  end
end

def update
 
  if @teacher.update_attributes(params[:teacher]) then
    #flash[:notice] = "Teacher Updated"
    redirect_to :action => 'index'
  else
    render :action => 'edit', :status => 400
  end
end

def destroy
  if !@teacher.has_shifts? then
    @teacher.destroy
    #flash[:notice] = "Teacher deleted"
    redirect_to teachers_path
  else
    @teacher.errors.add_to_base "Cannot delete teacher because its assgined to a shift"
    render :action => 'show', :status => 400
  end 
end

private 
def find_by_id
  @teacher = Teacher.find params[:id]
end

end
