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
    
    hour_overdue=(Time.now.to_i-issue_datetime.to_time.to_i)/3600
    reader_with_book.penalty hour_overdue
  end


  def could_meet_each_other? first_author, second_author
   first_author.can_meet?(second_author)
end

  def days_to_buy
    
    reader_with_book.book_price/reader_with_book.book_price*penalty/24
  end

  def transliterate author

  end

  

  def penalty_to_finish
  
    pages_to_end=(issue_datetime.to_time.to_i-Time.now.to_i)/3600*reader_with_book.reading_speed

    
    hour_overdue=(Time.now.to_i-issue_datetime.to_time.to_i)/3600

     if hour_overdue ==0    
         penalty_to_finish=(reader_with_book.time_to_finish*penalty).to_i
    end                                                                       

       if hour_overdue >0  
           penalty_to_finish =((hour_overdue+reader_with_book.time_to_finish)*penalty).to_i
      end

         if   hour_overdue<0 && reader_with_book.rest_pages<pages_to_end 
           penalty_to_finish==0 
           else penalty_to_finish=(reader_with_book.rest_pages-pages_to_end)/reader_with_book.reading_speed*penalty
         end
       
 end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
