class ShiftSweeper < ActionController::Caching::Sweeper
  observe Shift
  def after_save(shift)
    clear_cache_for(shift)
  end

  def after_destroy(shift)
    clear_cache_for(shift)
  end
  
  def clear_cache_for(shift)
    expire_page :controller => :courses, :action => :index
    expire_page :controller => :courses, :action => :show, :id => shift.course
  end
end
