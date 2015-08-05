class ReaderWithBook < Reader 
  
  attr_accessor :amaizing_book, :current_page

  def initialize  name, reading_speed, amaizing_book, current_page
    @amaizing_book = amaizing_book
    @current_page = current_page
    super name,  reading_speed
  end 

  def time_to_finish
    (amaizing_book.pages_quantity - current_page) / reading_speed
  end
  def penalty 
  	amaizing_book.penalty_per_hour
  	
  end
end
