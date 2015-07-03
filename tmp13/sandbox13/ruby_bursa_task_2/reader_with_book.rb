class ReaderWithBook < Reader
  attr_accessor :published_book, :current_page

  def initialize  name, reading_speed, published_book, current_page
    @published_book = published_book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    ((published_book.pages_quantity - current_page) / @reading_speed).round(0)
  end

  def book_price
  	published_book.price
  end

  def book_pages_quantity
  	published_book.pages_quantity
  end

  def book_published_at
  	published_book.published_at
  end

  def book_age
  	published_book.age
  end

  def book_hour_penalty
  	published_book.penalty_per_hour
  end

  def penalty_to_finish
  	published_book.penalty_per_hour*((published_book.pages_quantity - current_page) / @reading_speed).round(0)

  end


end
