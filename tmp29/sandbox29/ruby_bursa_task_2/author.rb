class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
     if year_of_birth > year_of_death || other_author.year_of_birth > other_author.year_of_death
      return false
    end

    life_time1 = (year_of_birth..year_of_death).to_a
    life_time2 = (other_author.year_of_birth..other_author.year_of_death).to_a
 
    return (life_time1 & life_time2).count > 0 ? true : false
  end
end
