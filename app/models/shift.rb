class Shift < DomainObject
  belongs_to :course
  belongs_to :teacher
  has_many :inscriptions, :dependent => :destroy
  
  validates_presence_of :course
  validates_inclusion_of :time, :in => %w(Night Afternoon Morning)
  validates_numericality_of :vacants, :greater_than => 49, :on => :create

def real_vacants
  vacants - inscriptions.size
end

def self.find_availables_for(student)

  shifts = Shift.find :all

  shifts.find_all do |s| 
     student.can_attend?(s)
  end

end

end
