require 'active_support/all'
require 'pry'

require './library_manager.rb'
require './author.rb'
require './book.rb'
require './published_book.rb'
require './reader.rb'
require './reader_with_book.rb'

describe LibraryManager do

  let(:leo_tolstoy) do
    Author.new(1828, 1910, 'Leo Tolstoy' ) 
  end
  let(:oscar_wilde) { Author.new(1854, 1900, 'Oscar Wilde') }
  let(:war_and_peace) { PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) }
  let(:ivan_testenko) { ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) }
  let(:manager) { LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) }

  

  it 'should count penalty' do
    expect (LibraryManager.new.penalty).to eq 48
  end

  it 'should know if author can meet another author' do
 
    expect (LibraryManager.new.could_meet_each_other? leo_tolstoy, oscar_wilde).to eq false
   
    
  #end  

  #it 'should count days to buy' do
   # manager.days_to_buy
  #end

  #it 'should transliterate ukrainian names' do
  #  ukrainan_author = Author.new(1856, 1916, 'rfjeriuh')
   # manager.transliterate ukrainan_author
  #end

  #it 'should count penalty to finish' do
   # manager.penalty_to_finish
  #end

  #it 'should compose email notifications' do
   # expect(manager.email_notification). to eq <<-TEXT
#Hello, some code!

#You should return a book "some code" authored by some code in some code hours.
#Otherwise you will be charged $some code per hour. 
#TEXT
  end
  
end