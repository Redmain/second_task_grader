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
    penalty = 0
    hours_overdue = ((Time.now.utc.to_1 - issue_datetime.to_time.to_1) / 3600)
    price_penalty = reader_with_book_price*hours_overdue * hours_to_fifnish *0.001
    pages_penalty = 0.000003 * reader_with_book_price *reader_with_book.book_pages_quanlity * hours_overdue
    book_age = reader_with_book.book_age
    age_penalty = 0.00007 * reader_with_book.bool_price * book_age * hours_overdue

    puts (price_penalty * pages_penalty * age_penalty).round

  end

  def could_meet_each_other? first_author, second_author
      first_author.can_meet?(second_author)

  end

  def days_to_buy

    day = new.PublishedBook.days
  end

  def transliterate author
    author_author.author_translit

  end

  def penalty_to_finish

  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
