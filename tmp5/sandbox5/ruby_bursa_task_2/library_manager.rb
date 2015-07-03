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

  def penalty_tax currDate = DateTime.now.new_offset(0)
    return ((0.00007 * reader_with_book.book.ageY(currDate)) + (0.000003 * reader_with_book.book.pages_quantity) + 0.0005)
  end

  def penalty
    hoursAgo = ((DateTime.now.new_offset(0) - issue_datetime).to_f * 24).round
    res = if hoursAgo > 0
      penalty_tax * reader_with_book.book.price * hoursAgo
    else
      0
    end
    return res.round
  end

  def could_meet_each_other? first_author, second_author
    return first_author.can_meet? second_author
  end

  def days_to_buy
    res = 1 / penalty_tax / 24
    return res.round
  end

  def transliterate author
    ukrArray = Array.[]("А", "Б", "В", "Г", "Ґ", "Д", "Е", "Є", "Ж", "З", "И", "І", "Ї", "Й", "К", "Л", "М", "Н",
    "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ю", "Я", "а", "б", "в", "г", "ґ", "д", "е", "є", "ж", "з", "и", "і", "ї", "й", "к", "л", "м", "н",
    "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ю", "я")
    translitArray = Array.[]("A", "B", "V", "H", "G", "D", "E", "Ye", "Zh", "Z", "Y", "I", "Yi", "Y", "K", "L", "M", "N",
    "O", "P", "R", "S", "T", "U", "F", "Kh", "Ts", "Ch", "Sh", "Shch", "Yu", "Ya", "a", "b", "v", "h", "g", "d", "e", "ie", "zh", "z", "y", "i", "i", "i", "k", "l", "m", "n",
    "o", "p", "r", "s", "t", "u", "f", "kh", "ts", "ch", "sh", "shch", "iu", "ia")
    res = ""
    author.name.each_char {|c| res = res + (ukrArray.index(c) == nil ? c : translitArray[ukrArray.index(c)])}
    return res
  end

  def penalty_to_finish
    dtFinish = DateTime.now.new_offset(0) + reader_with_book.time_to_finish.hours
    res = dtFinish > issue_datetime ? penalty_tax(dtFinish) * reader_with_book.book.price * ((dtFinish - issue_datetime).to_f * 24).round : 0
    return res.round
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
