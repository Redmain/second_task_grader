class ReaderWithBook < Reader
  attr_accessor :book, :current_page

  def initialize  name, reading_speed, book, current_page
    @book = book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    ((book.pages_quantity - current_page) / reading_speed).ceil
  end

  def penalty_per_hour
  	book.penalty_per_hour
  end

  def penalty_per_day
    penalty_per_hour*24
  end

  def price
    book.price
  end

  def end_time
     Time.now.utc.to_i+(time_to_finish*3600)
  end


end
