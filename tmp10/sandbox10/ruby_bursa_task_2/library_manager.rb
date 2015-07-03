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
    price_penalty = reader_with_book.book_price * hours_overdue * 0.0005
    pages_penalty = 0.000003 * reader_with_book.book_price * reader_with_book.book_pages_quantity * hours_overdue
    age_penalty = 0.00007 * reader_with_book.book_price * reader_with_book.book.age * hours_overdue

  
    #binding.pry
    penalty = (price_penalty + pages_penalty + age_penalty).round


  end




  def could_meet_each_other? first_author, second_author





  end

  def days_to_buy

  end

  def transliterate author

  end

  def penalty_to_finish

  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
