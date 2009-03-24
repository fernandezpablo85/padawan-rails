class Course < DomainObject
  has_many :shifts, :dependent => :destroy
  validates_length_of :name, :within => 5..20

  validates_length_of :description, :within => 10..100
end
