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
    hours_overdue =((Time.now.utc.to_i- issue_datetime.to_time.to_i)/3600)
     
    return 0 if hours_overdue < 0 || reader_with_book.penalty_per_hour < 0  

    (reader_with_book.penalty_per_hour * hours_overdue).round
  end

  def could_meet_each_other? first_author, second_author
    first_author.can_meet? second_author
  end

  def days_to_buy

    return 0 if reader_with_book.penalty_per_day <= 0

    (reader_with_book.price/reader_with_book.penalty_per_day).ceil 
       
  end

  def transliterate author
    author.transliteration
  end

  def penalty_to_finish
    difference_in_time = reader_with_book.end_time - issue_datetime.to_time.utc.to_i

    return 0 if difference_in_time < 0 || reader_with_book.penalty_per_hour < 0 

    (reader_with_book.penalty_per_hour*(difference_in_time/3600)).round
  end

  def email_notification_params
    {
      penalty:"soome code"

    }

  end

  def email_notification
    
  end

end
