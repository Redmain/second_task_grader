require 'active_support/all'
require 'pry'

require_relative 'author.rb'
require_relative 'book.rb'
require_relative 'published_book.rb'
require_relative 'reader.rb'
require_relative 'reader_with_book.rb'

class LibraryManager

  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end

  def penalty
      
      hours_overdue = ((Time.now.utc.to_i - issue_datetime.to_time.to_i)/3600)

    penalty_age = 0.00007 *  reader_with_book.book.published_at * reader_with_book.book.price
    penalty_pages = 0.000003 * reader_with_book.book.pages_quantity * reader_with_book.book.price
    penalty_price = 0.0005 * reader_with_book.book.price * hours_overdue
   
    (penalty_age + penalty_pages + penalty_price).round
  end
  

  def could_meet_each_other? first_author, second_author
    second_author.year_of_birth >= first_author.year_of_death || first_author.year_of_birth >= second_author.year_of_death ? false : true

  end


  def days_to_buy
    days_to_buy = (reader_with_book.book.price / (penalty_per_hour * 24)).round
puts days_to_buy
  end

  def transliterate author
    replace = {
      'а' => 'a', 'б' => 'b', 'в' => 'v',
      'г' => 'h', 'д' => 'd', 'е' => 'e', 'є' => 'ie',
      'ж' => 'zh', 'з' => 'z', 'і' => 'i',
      'и' => 'y', 'й' => 'i', 'к' => 'k', 'ї' => 'i',
      'л' => 'l', 'м' => 'm', 'н' => 'n', 'ґ' => 'g',
      'о' => 'o', 'п' => 'p', 'р' => 'r',
      'с' => 's', 'т' => 't', 'у' => 'u',
      'ф' => 'f', 'х' => 'kh', 'ц' => 'ts',
      'ч' => 'ch', 'ш' => 'sh', 'щ' => 'shch',
      'ю' => 'iu', 'я' => 'ia',
 
      'А' => 'A', 'Б' => 'B', 'В' => 'V',
      'Г' => 'H', 'Д' => 'D', 'Е' => 'E', 'Є' => 'Ye',
      'Ж' => 'Zh', 'З' => 'Z', 'І' => 'I',
      'И' => 'Y', 'Й' => 'Y', 'К' => 'K', 'Ї' => 'Yi',
      'Л' => 'L', 'М' => 'M', 'Н' => 'N', 'Ґ' => 'G',
      'О' => 'O', 'П' => 'P', 'Р' => 'R',
      'С' => 'S', 'Т' => 'T', 'У' => 'U',
      'Ф' => 'F', 'Х' => 'Kh', 'Ц' => 'Ts',
      'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Shch',
      'Ю' => 'Yu', 'Я' => 'Ya', ' ' => ' '
      }
      author.name.gsub(/#{replace.keys}/, replace)

  end

  def penalty_to_finish

    finish_time = DateTime.now.new_offset(0) + reader_with_book.time_to_finish.hours
    overtime = (finish_time - issue_datetime) * 24
    overtime > 0 ? penalty_to_finish = (overtime * penalty_per_hour * 24).ceil : penalty_to_finish = 0

    end

  def email_notification_params
      {
        penalty: "some code",
        hours_to_deadline: "some code",
      }
  end

  def email_notification
    #use email_notification_params
  end

end


#binding.pry
#leo_tolstoy = Author.new(1828, 1910, 'Leo Tolstoy')
#oscar_wilde = Author.new(1854, 1900, 'Oscar Wilde')
#ukrainian_author = Author.new(1856, 1916, 'Іван Франко')

#war_and_peace = PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) 
#ivan_teslenko = ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) 
#manager = LibraryManager.new(ivan_teslenko, (DateTime.now.new_offset(0) - 2.days)) 
#puts "Hello word!"
#p manager.penalty
#p manager.could_meet_each_other? leo_tolstoy, oscar_wilde
#p manager.days_to_buy
#p manager.transliterate ukrainian_author
#p manager.penalty_to_finish


#p manager.email_notification_params