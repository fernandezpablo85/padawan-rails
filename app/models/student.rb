class Student < DomainObject
  has_many :inscriptions
  has_many :shifts, :through => :inscriptions

  validates_length_of     :name,  :within => 5..30
  validates_inclusion_of  :age,   :in => 10..99, 
                                  :message => "must be between 10 and 99"


  def can_attend?(shift)
    !has_shift?(shift) && !times.include?(shift.time)
  end

  private

  def times
    shifts.collect {|s| s.time }.uniq
  end

  def has_shift?(s)
    shifts.include?(s)
  end

end
