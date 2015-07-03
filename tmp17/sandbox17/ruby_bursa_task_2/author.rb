class Author
 attr_accessor :year_of_birth, :year_of_death, :name

def initialize year_of_birth, year_of_death, name
@year_of_birth = year_of_birth
@year_of_death = year_of_death
@name = name
end

def can_meet? (other)
	(year_of_birth<other.year_of_birth)&(year_of_death<other.year_of_birth)||(other.year_of_birth<year_of_birth)&(year_of_death<other.year_of_death)
     true
       
end


end
