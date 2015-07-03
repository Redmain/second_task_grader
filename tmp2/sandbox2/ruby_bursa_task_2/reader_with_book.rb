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

  def penalty hours
  	(amazing_book.penalty_per_hour * hours).round
  end

  def price_book
      amazing_book.price
  end

end
