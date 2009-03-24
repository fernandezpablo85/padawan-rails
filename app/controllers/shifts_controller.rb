class ShiftsController < ApplicationController

  #======Filters========
  before_filter :find_course, :except => :list_teachers
  #=====================
  
  #======Page Cache=====
  cache_sweeper :shift_sweeper
  #=====================
  
def new
  @shift = Shift.new
end

def create
  @shift = Shift.new(params[:shift])
  @shift.course = @course
  if @shift.save then
    redirect_to course_path(@course)
  else
    render :action => 'new', :status => 400
  end
end

def destroy
  @shift = Shift.find(params[:id])
  @shift.destroy
  redirect_to course_path(@course)
end

def list_teachers
  @shift = Shift.find(params[:shift_id])
  @teachers = Teacher.available_for(@shift.time)
end  

def add_teacher
  @shift = Shift.find(params[:shift_id])
  @teacher = Teacher.find_by_name params[:teacher_name]
  @shift.teacher = @teacher

  redirect_to course_path(@course)
end

private

def find_course
  @course = Course.find params[:course_id]
end
end
