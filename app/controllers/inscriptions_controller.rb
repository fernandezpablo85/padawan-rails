class InscriptionsController < ApplicationController

before_filter :find_student

def index
  @shifts = Shift.find_availables_for(@student)
end

def create; end

def inscribe
  @shift = Shift.find params[:shift_id]
  @student.shifts << @shift
  @student.save
  flash[:notice] = "Inscription Ok"
  redirect_to student_path(@student)
end

def destroy
  @inscription = Inscription.find(params[:id])
  @student.inscriptions.delete(@inscription)
  @inscription.destroy
  @student.save
  flash[:notice] = "Inscription cancelled"
  redirect_to student_path(@student)
end 

private

def find_student
  @student = Student.find params[:student_id]
end

end
