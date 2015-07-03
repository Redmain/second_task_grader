require 'active_support/all'
require 'pry'
class LibraryManager
  require_relative 'author.rb'
  require_relative 'book.rb'
  require_relative 'published_book.rb'
  require_relative 'reader.rb'
  require_relative 'reader_with_book.rb'
  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end


  def penalty
    
    hours_overdue = ((Time.now.utc.to_i - issue_datetime.to_time.to_i) / 3600)
    
    reader_with_book.penalty hours_overdue
#binding.pry
  end

  def could_meet_each_other? first_author, second_author

   if (first_author.lifetime & second_author.lifetime).size > 0
       return true
      else
       return false
      end 

  end

  def days_to_buy
     (reader_with_book.price_book / (reader_with_book.penalty  24)).to_i + 1

  end

  def transliterate author
replace = {

        'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'h',   'д' => 'd',   'е' => 'e',   'є' => 'ie',
        'ж' => 'zh',  'з' => 'z',   'і' => 'i',
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

   author.name.gsub(/#{replace.keys}/, replace)
  #binding.pry
  end

  def penalty_to_finish
    day_of_end = (reader_with_book.time_to_finish / 24.0)
    end_datetime=(DateTime.now.new_offset(0) + day_of_end.days) 
    
    hr = (end_datetime - issue_datetime) * 24.0
    
    end_datetime > issue_datetime ? reader_with_book.penalty(hr) : 0
#binding.pry
  end

  
  def email_notification_params
    {
      penalty: "some code",
      hurs_to_dedline: "some code",

    }

  end

  def email_notification
    #email_notification_params

  end
end

leo_tolstoy = Author.new(1828, 1910, 'Leo Tolstoy')
oscar_wilde = Author.new(1854, 1900, 'Oscar Wilde')
ukrainan_author = Author.new(1856, 1916, 'Іван Франко')
war_and_peace = PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) 
ivan_testenko = ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) 
manager = LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) 


p manager.penalty
p manager.could_meet_each_other? leo_tolstoy, oscar_wilde
p manager.days_to_buy
p manager.transliterate ukrainan_author
p manager.penalty_to_finish

