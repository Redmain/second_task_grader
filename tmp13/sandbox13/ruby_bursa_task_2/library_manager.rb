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
    hours_overdue = (Time.now.utc.to_i - issue_datetime.to_time.to_i)/3600
    reader_with_book.book_hour_penalty*hours_overdue  
  end

  def could_meet_each_other? first_author, second_author
    first_author.can_meet?(second_author) 
  end

  def days_to_buy
    day_penalty = reader_with_book.book_hour_penalty*24
    reader_with_book.book_price/day_penalty.to_i
  end

  def transliterate author
    author.translit_to_eng 
  end

  def penalty_to_finish
    a = reader_with_book.time_to_finish 
    b = reader_with_book.book_hour_penalty
    penalty_to_finish = a * b
  end
  
  # this is a placeholder. Just ignore it for the moment.
  #def email_notification_params

  #end

  #def email_notification

  #end

end
