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
    diff = DateTime.now - @issue_datetime
    diff <= 0 ? 0 : @reader_with_book.penalty_per_hour(diff * 24)
  end

  def could_meet_each_other? first_author, second_author
    first_author.can_meet? second_author
  end

  def days_to_buy
    @reader_with_book.time_to_finish
  end

  def transliterate author
    letters = {"А": "A","а": "a","Б": "B","б": "b","В": "V","в": "v","Г": "H","г": "h","Ґ": "G",
      "ґ": "g","Д": "D","д": "d","Е": "E", "е": "e", "Є": "Y","є": "ie","Ж": "Zh","ж": "zh","З": "Z","з": "z",
      "И": "Y","и": "y","І": "I","і": "i","ї": "i","Й": "Y","й": "i","К": "K","к": "k","Л": "L",
      "л": "l","М": "M","м": "m","Н": "N","н": "n","О": "O","о": "o","П": "P","п": "p","Р": "R",
      "р": "r","С": "S","с": "s","Т": "T","т": "t", "У": "U","у": "u","Ф": "F","ф": "f","Х": "Kh",
      "х": "kh","Ц": "Ts","ц": 'ts',"Ч": "Ch","ч": "ch","Ш": "Sh","ш": "sh","Щ": "Shch","щ": "shch",
      "Ю": "Y","ю": "iu","Я": "Ya","я": "ia", "ь": "", "'": "", "’": ""}
    author.name.gsub(/./) { |c| letters.has_key?(c.to_sym) ? letters[c.to_sym] : c }
  end

  def penalty_to_finish
    pages = @reader_with_book.book_pages_quantity
    current = @reader_with_book.current_page
    speed = @reader_with_book.reading_speed
    estimated_time = DateTime.now + Rational((pages - current) / speed, 24)
    diff = @issue_datetime - estimated_time
    diff >= 0 ? 0 : -@reader_with_book.penalty_per_hour(diff * 24)
  end

  def email_notification_params
    {
      name:    "#{@reader_with_book.name}",
      book:    "#{@reader_with_book.book_title}",
      author:  "#{@reader_with_book.book_author}",
      penalty_per_hour:  "#{@reader_with_book.book.fine()}",
      penalty:           "#{penalty()}",
      hours_to_deadline: "#{(@issue_datetime - DateTime.now.new_offset(0)).round * 24}"
    }
  end

  def email_notification
    <<-TEXT
      Hello, #{email_notification_params[:name]}!\n
      #{ if email_notification_params[:hours_to_deadline].to_i <= 0
            "You must return the book \"#{email_notification_params[:book]}\" authored by #{email_notification_params[:author]} as soon as possible!\n
      You already owe the library $#{sprintf('%.2f', email_notification_params[:penalty].to_f / 100.0)} (¢#{email_notification_params[:penalty]}) and you are charged ¢#{email_notification_params[:penalty_per_hour]} every hour.\n
      Your overdue for the moment is #{-email_notification_params[:hours_to_deadline].to_i}."
         else 
            "You should return the book \"#{email_notification_params[:book]}\" authored by #{email_notification_params[:author]} in #{email_notification_params[:hours_to_deadline]} hours.\n
      Otherwise you will be charged ¢#{email_notification_params[:penalty_per_hour]} per hour."
         end
      }
    TEXT
  end

end
