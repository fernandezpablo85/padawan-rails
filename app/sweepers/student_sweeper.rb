class StudentSweeper < ActionController::Caching::Sweeper

observe Student

def after_save(student)
  clear_cache_for(student)
end

def after_destroy(student)
  clear_cache_for(student)
end

private
def clear_cache_for(student)
  expire_page '/students'
  expire_page :controller => :students, :action => :index
  expire_page :controller => :students, :action => :show, :id => student
end
end