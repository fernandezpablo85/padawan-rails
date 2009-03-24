class Inscription < DomainObject
  belongs_to :student
  belongs_to :shift

  validates_inclusion_of :how, :in => %w(Web Tv Mail), :allow_nil => true
  
  validates_presence_of :student, :shift
end
