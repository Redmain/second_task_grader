class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
  		range = @year_of_birth.to_i..@year_of_death.to_i
      	range.include?(other_author.year_of_birth.to_i)||range.include?(other_author.year_of_death.to_i)
  end
end
