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
    hours_overdue = (Time.now.utc.to_i - issue_datetime.to_i)/3600
    (reader_with_book.amaizing_book.penalty_per_hour * hours_overdue).round
    
  end

  def could_meet_each_other? first_author, second_author
    
    ((first_author.year_of_birth<first_author.year_of_death)&&(second_author.year_of_birth<second_author.year_of_death))&&((second_author.year_of_birth<=first_author.year_of_death)&&(first_author.year_of_birth<=second_author.year_of_death))
    
  end

  def days_to_buy
    return 0 if reader_with_book.amaizing_book.price <= 0
    ((reader_with_book.amaizing_book.price / reader_with_book.amaizing_book.penalty_per_hour)/24).round

  end

  def transliterate author

    
  end

  def penalty_to_finish
    now_date = DateTime.now.new_offset(0)
    
    difference_in_time = ((now_date.to_time + reader_with_book.time_to_finish*3600)-issue_datetime.to_time).to_i/3600
    if difference_in_time <= 0 
      return 0
     else 
    return (difference_in_time * reader_with_book.amaizing_book.penalty_per_hour).round
    end
    
  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
