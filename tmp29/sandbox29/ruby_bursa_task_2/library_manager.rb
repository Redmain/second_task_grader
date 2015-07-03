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
    date_now = DateTime.now.new_offset( 0 )    
    price = reader_with_book.book_price
    return 0 if issue_datetime >= date_now || price < 0

    hours_overdue = (date_now.to_time - issue_datetime.to_time).to_i / 3600
    
    reader_with_book.penalty hours_overdue
  end
 
  def could_meet_each_other? first_author, second_author
    first_author.can_meet? second_author
  end

  def days_to_buy
    price = reader_with_book.book_price
    return 0 if price <= 0
     
    date_now = DateTime.now.new_offset( 0 )
    hours_total = 0
    date_beginning = date_now    
    
    days = 0
    loop do
      year = date_beginning.year      
      date_end = DateTime.new(year, 12, 31, 23, 59, 59).new_offset( 0 )
      
      hours_total = ((date_end.to_time - date_beginning.to_time).to_i / 3600) + hours_total
      penalty_hour = reader_with_book.book_penalty_per_hour_from_date date_beginning 
     
      hours_for_reading = price / penalty_hour 

      if hours_total >= hours_for_reading
        days = hours_for_reading / 24
        break
      else
         date_beginning = DateTime.new(year + 1).new_offset( 0 )
      end
    end
    days.round
  end

  def transliterate author
    str = ""

    first_char_name = true
    author.name.each_char do |char|

      case char
      when 'А'
        str = str + 'A'
      when 'а'
        str = str + 'a'
      when 'Б'
        str = str + 'B'
      when 'б'
        str = str + 'b'
      when 'В'
        str = str + 'V'
      when 'в'
        str = str + 'v'
      when 'Г'
        str = str + 'H'
      when 'г'
        str = str + 'h'
      when 'Ґ'
        str = str + 'G'
      when 'ґ'
        str = str + 'g'
      when 'Д'
        str = str + 'D'
      when 'д'
        str = str + 'd'
      when 'Е'
        str = str + 'E'
      when 'е'
        str = str + 'e'
      when 'Є'
        translit = first_char_name ? 'Ye' : 'Ie'
        str = str + translit
      when 'є'
        translit = first_char_name ? 'ye' : 'ie'
        str = str + translit
      when 'Ж'
        str = str + 'Zh'
      when 'ж'
        str = str + 'zh'
      when 'З'
        str = str + 'Z'
      when 'з'
        str = str + 'z'
      when 'И'
        str = str + 'Y'
      when 'и'
        str = str + 'y'
      when 'І'
        str = str + 'I'
      when 'і'
        str = str + 'i'
      when 'Ї'
        translit = first_char_name ? 'Yi' : 'I'
        str = str + translit
      when 'ї'
        translit = first_char_name ? 'yi' : 'i'
        str = str + translit
      when 'Й'
        translit = first_char_name ? 'Y' : 'I'
        str = str + translit
      when 'й'
        translit = first_char_name ? 'y' : 'i'
        str = str + translit
      when 'К'
        str = str + 'K'
      when 'к'
        str = str + 'k'
      when 'Л'
        str = str + 'L'
      when 'л'
        str = str + 'l'
      when 'М'
        str = str + 'M'
      when 'м'
        str = str + 'm'
      when 'Н'
        str = str + 'N'
      when 'н'
        str = str + 'n'
      when 'О'
        str = str + 'O'
      when 'о'
        str = str + 'o'
      when 'П'
        str = str + 'P'
      when 'п'
        str = str + 'p'
      when 'Р'
        str = str + 'R'
      when 'р'
        str = str + 'r'
      when 'С'
        str = str + 'S'
      when 'с'
        str = str + 's'
      when 'Т'
        str = str + 'T'
      when 'т'
        str = str + 't'
      when 'У'
        str = str + 'U'
      when 'у'
        str = str + 'u'
      when 'Ф'
        str = str + 'F'
      when 'ф'
        str = str + 'f'
      when 'Х'
        str = str + 'Kh'
      when 'х'
        str = str + 'kh'
      when 'Ц'
        str = str + 'Ts'
      when 'ц'
        str = str + 'ts'
      when 'Ч'
        str = str + 'Ch'
      when 'ч'
        str = str + 'ch'
      when 'Ш'
        str = str + 'Sh'
      when 'ш'
        str = str + 'sh'
      when 'Щ'
        str = str + 'Shch'
      when 'щ'
        str = str + 'shch'
      when 'Ю'
        translit = first_char_name ? 'Yu' : 'Iu'
        str = str + translit
      when 'ю'
        translit = first_char_name ? 'yu' : 'iu'
        str = str + translitr
      when 'Я'
        translit = first_char_name ? 'Ya' : 'Ia'
        str = str + translit
      when 'я'
        translit = first_char_name ? 'ya' : 'ia'
        str = str + translit
      end        

      if char == ' ' || char == '-' 
        str = str + char
        first_char_name = true
      else
        first_char_name = false
      end

    end
    
    str
  end

  def penalty_to_finish
    price = reader_with_book.book_price
    return 0 if reader_with_book.reading_speed <= 0 || price <= 0

    date_now = DateTime.now.new_offset( 0 )
    time_when_read = date_now.to_time + (reader_with_book.time_to_finish * 3600)
    time_issue = issue_datetime.to_time
 
    if time_when_read > time_issue
      
      hours = (time_when_read - time_issue).to_i / 3600

      penalty_hour = reader_with_book.book_penalty_per_hour_from_date time_when_read
      penalty = penalty_hour * hours
      
      penalty.round

    else
      penalty = 0
    end  
  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
