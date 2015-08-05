class Reader < PublishedBook
  attr_accessor :name, :reading_speed

  def initialize name, reading_speed 
    @name = name
    @reading_speed = reading_speed
    #super penalty_per_hour

  end
  def pages_to_end
  	
  	
  end

end
