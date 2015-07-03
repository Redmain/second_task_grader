class ReaderWithBook < Reader
  attr_accessor :book, :current_page

  def initialize  name, reading_speed, book, current_page
    @book = book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    (book.pages_quantity - current_page) / reading_speed
  end
end
