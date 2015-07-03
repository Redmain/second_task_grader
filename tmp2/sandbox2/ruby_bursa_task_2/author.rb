class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author

  end
  

  def lifetime 
  	year = year_of_death - year_of_birth

  	 Array.new(year){ |index| year_of_birth + index + 1 }
  	 
  end



end
