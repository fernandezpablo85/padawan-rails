class Teacher < DomainObject
  has_many :shifts

  validates_length_of :name, :within => 5..30
  validates_format_of :mail,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

def self.available_for(time)

 teachers = Teacher.find :all, :include => :shifts
 teachers.find_all {|t| t.is_available_for? time}

end

def busy_times

  shifts.collect{|s| s.time}.uniq  

end

def is_available_for?(time)

  !busy_times.include?(time)

end

end
