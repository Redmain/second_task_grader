class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
  	lifeOfAutor = (year_of_birth..year_of_death)
    lifeOfOtherAutor = (other_author.year_of_birth..other_author.year_of_death)
    return lifeOfAutor.overlaps?lifeOfOtherAutor
  end
end
