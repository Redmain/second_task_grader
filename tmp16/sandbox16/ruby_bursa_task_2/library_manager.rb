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
    hours_overdue = ((Time.now.utc.to_i - issue_datetime.to_i)/3600)
    reader_with_book.penalty(hours_overdue).round
    
  end

  def could_meet_each_other? first_author, second_author
    
    ((first_author.year_of_birth<first_author.year_of_death)&&(second_author.year_of_birth<second_author.year_of_death))&&((second_author.year_of_birth<=first_author.year_of_death)&&(first_author.year_of_birth<=second_author.year_of_death))
    
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
