class CourseSweeper < ActionController::Caching::Sweeper

observe Course

def after_save(course)
  clear_cache_for(course)
end

def after_destroy(course)
  clear_cache_for(course)
end

private
def clear_cache_for(course)
  expire_page :controller => :courses, :action => :index
  expire_page :controller => :courses, :action => :show, :id => course
end
end
