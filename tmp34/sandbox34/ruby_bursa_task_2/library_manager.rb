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
    ((DateTime.now.new_offset(0) - issue_datetime).to_f*24 * reader_with_book.book.penalty_an_hour).round
  end

  def could_meet_each_other? first_author, second_author
    first_author.can_meet?(second_author)
  end

  def days_to_buy
     (reader_with_book.book.price/reader_with_book.book.penalty_an_hour/24).round
  end

  def transliterate author
   arr = {"А" => "A", "Б" => "B", "В" => "V", "Г" => "H", "Ґ" => "G", "Д" => "D", "Е" => "E", "Є" => "Ye", "Ж" => "Zh", "З" => "Z", 
      "И" => "Y", "І" => "I", "Ї" => "Yi", "Й" => "Y", "К" => "K", "Л" => "L", "М" => "M", "Н" => "N", "О" => "O", "П" => "P", "Р" => "R", 
      "С" => "S", "Т" => "T", "У" => "U", "Ф" => "F", "Х" => "Kh", "Ц" => "Ts", "Ч" => "Ch", "Ш" => "Sh", "Щ" => "Shch", "Ю" => "Yu", 
      "Я" => "Ya", " " => " ", "'" => "'", "-" => "-",
      "а" => "a", "б" => "b", "в" => "v", "г" => "h", "ґ" => "g", "д" => "d", "е" => "e", "є" => "ie", "ж" => "zh", "з" => "z",       "и" => "y", "і" => "i", "ї" => "i", "й" => "i", "к" => "k", "л" => "l", "м" => "m", "н" => "n", "о" => "o", "п" => "p", "р" => "r", 
      "с" => "s", "т" => "t", "у" => "u", "ф" => "f", "х" => "kh", "ц" => "ts", "ч" => "ch", "ш" => "sh", "щ" => "shch", "ю" => "iu", 
      "я" => "ia" }
    newstr = ""
    author.name.each_char  {|c| newstr << arr[c] }
    newstr
  end

  def penalty_to_finish
    #timetoread = (pages_quantity - current_page)/reading_speed
    penalty = (((DateTime.now.new_offset(0) - issue_datetime) * 24 + reader_with_book.time_to_finish) * reader_with_book.book.penalty_an_hour ).round
    penalty < 0 ? 0 : penalty
  end

  def email_notification_params
      {
        penalty: "some code",
        hours_to_deadline: "some code",
      }
  end

  def email_notification
    #use email_notification_params
    <<-TEXT
Hello, some code!

You should return a book "some code" authored by some code in some code hours.
Otherwise you will be charged $some code per hour. 
TEXT
  end

end
