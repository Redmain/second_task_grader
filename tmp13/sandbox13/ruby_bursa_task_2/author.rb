class Author
  attr_accessor :year_of_birth, :year_of_death, :name

  def initialize year_of_birth, year_of_death, name
    @year_of_birth = year_of_birth
    @year_of_death = year_of_death
    @name = name
  end

  def can_meet? other_author
  	[other_author.year_of_birth, other_author.year_of_death].any? {|i| life_time.include?(i)}
  end

  def life_time
    @year_of_birth..@year_of_death
  end

  def translit_to_eng

  translit = {

        'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'h',   'д' => 'd',   'е' => 'e',   'є' => 'ie',
        'и' => 'y',   'й' => 'i',   'к' => 'k',   'ї' => 'i',
        'л' => 'l',   'м' => 'm',   'н' => 'n',   'ґ' => 'g',
        'о' => 'o',   'п' => 'p',   'р' => 'r',
        'с' => 's',   'т' => 't',   'у' => 'u',
        'ф' => 'f',   'х' => 'kh',  'ц' => 'ts',
        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'shch',
        'ю' => 'iu',  'я' => 'ia',

        'А' => 'A',   'Б' => 'B',   'В' => 'V',
        'Г' => 'H',   'Д' => 'D',   'Е' => 'E',   'Є' => 'Ye',
        'Ж' => 'Zh',  'З' => 'Z',   'І' => 'I',
        'И' => 'Y',   'Й' => 'Y',   'К' => 'K',   'Ї' => 'Yi',
        'Л' => 'L',   'М' => 'M',   'Н' => 'N',   'Ґ' => 'G',
        'О' => 'O',   'П' => 'P',   'Р' => 'R',
        'С' => 'S',   'Т' => 'T',   'У' => 'U',
        'Ф' => 'F',   'Х' => 'Kh',  'Ц' => 'Ts',
        'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Shch',
        'Ю' => 'Yu',  'Я' => 'Ya', ' ' => ' '
    }

    eng_name = @name.gsub(/#{translit.keys}/ , translit)

    end 



 

end
