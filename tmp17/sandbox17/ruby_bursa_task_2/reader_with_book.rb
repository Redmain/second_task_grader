class ReaderWithBook < Reader
  attr_accessor :amazing_book, :current_page

  def initialize  name, reading_speed, amazing_book, current_page
    @amazing_book = amazing_book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    (amazing_book.pages_quantity - current_page) / reading_speed
  end
  
  def rest_pages
  	amazing_book.pages_quantity - current_page
  
  end
  def book_price
  	amazing_book.price
  end
  def book_pages_quantity
  	amazing_book.pages_quantity
  end
  def book_published_at
  	amazing_book.published_at
  end
  def book_age
  	Time.now.utc.year - book_published_at - 1
  end
  def penalty hours
  	(amazing_book.penalty_per_hour*hours).round
  end

end
