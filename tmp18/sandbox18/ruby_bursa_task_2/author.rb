class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
  	    b = case
        when year_of_birth>year_of_death||other_author.year_of_birth>other_author.year_of_death
          "Error"
        when year_of_birth<=other_author.year_of_birth&&other_author.year_of_birth<=year_of_death
          true
        when year_of_birth<=other_author.year_of_death&&other_author.year_of_death<=year_of_death
          true 
        when other_author.year_of_birth<=year_of_birth&&year_of_birth<=other_author.year_of_death
          true
        when other_author.year_of_birth<=year_of_death&&year_of_death_first<=other_author.year_of_death
          true
        else
          false
      end
    b
  end

  def transliteration
  	ukr_chars = @name.chars


    translit = {'а'=>'a', 'б'=>'b', 'в'=>'v', 'г'=>'h', 'ґ'=>'g', 'д'=>'d', 'е'=>'e', 'є'=>'ie',
            'ж'=>'zh', 'з'=>'z', 'и'=>'y', 'і'=>'i', 'ї'=>'i', 'й'=>'i', 'к'=>'k', 'л'=>'l',
            'м'=>'m', 'н'=>'n', 'о'=>'o', 'п'=>'p', 'р'=>'r', 'с'=>'s', 'т'=>'t', 'у'=>'u',
            'ф'=>'f', 'х'=>'kh', 'ц'=>'ts', 'ч'=>'ch', 'ш'=>'sh', 'щ'=>'shch', 'ю'=>'iu',
            'я'=>'ia', 'А'=>'A','Б'=>'B', 'В'=>'V', 'Г'=>'H', 'Ґ'=>'G', 'Д'=>'D', 'Е'=>'E', 'Є'=>'Ye', 
            'Ж'=>'Zh', 'З'=>'z','И'=>'Y', 'І'=>'I', 'Ї'=>'Yi', 'Й'=>'Y', 'К'=>'K', 'Л'=>'L', 'М'=>'M',
            'Н'=>'N', 'О'=>'O','П'=>'P', 'Р'=>'R', 'С'=>'S','Т'=>'T', 'У'=>'U', 'Ф'=>'F', 'Х'=>'Kh', 
            'Ц'=>'Ts0', 'Ч'=>'Ch','Ш'=>'Sh', 'Щ'=>'Shch', 'Ю'=>'Yu', 'Я'=>'Ya', ' '=>' ','-'=>'-',}

    i = 0 
    eng_chars = Array.new

    begin
      eng_chars[i]  = translit.values_at(ukr_chars[i])
      i+=1
    end while i < ukr_chars.length

    eng_chars.join
  	
  end
end
