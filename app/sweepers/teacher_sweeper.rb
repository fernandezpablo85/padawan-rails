class TeacherSweeper < ActionController::Caching::Sweeper

observe Teacher

def after_save(teacher)
  clear_cache_for(teacher)
end

def after_destroy(teacher)
  clear_cache_for(teacher)
end

private
def clear_cache_for(teacher)
  expire_page :controller => :teachers, :action => :index
  expire_page :controller => :teachers, :action => :show, :id => teacher
end
end