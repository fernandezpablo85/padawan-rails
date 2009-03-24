class DomainObject < ActiveRecord::Base

  #Abstract
  self.abstract_class = true

  before_save :sanitize_html!

  def sanitize_html!
    attributes.each_value do |at| 
      at.gsub!(/<\/?[^>]*>/,'') if at.kind_of? String
    end
  end

end
