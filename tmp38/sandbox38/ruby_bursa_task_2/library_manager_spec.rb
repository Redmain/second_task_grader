require './library_manager.rb'

describe LibraryManager do

  let(:leo_tolstoy) do
    Author.new(1828, 1910, 'Leo Tolstoy') 
  end
  let(:oscar_wilde) { Author.new(1854, 1900, 'Oscar Wilde') }
  let(:war_and_peace) { PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) }
  let(:ivan_testenko) { ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) }
  let(:manager) { LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) }

  it 'should count penalty' do
    expect(manager.penalty). to eq 'sometext'
  end

  it 'should know if author can meet another author' do
    expect(manager.could_meet_each_other? leo_tolstoy, oscar_wilde). to eq 'sometext'
  end  

  it 'should count days to buy' do
    expect(manager.days_to_buy). to eq 'sometext'
  end

  it 'should transliterate ukrainian names' do
    ukrainan_author = Author.new(1856, 1916, 'Іван Франко')
    expect(manager.transliterate ukrainan_author). to eq 'sometext'
  end

  it 'should count penalty to finish' do
    expect(manager.penalty_to_finish). to eq 'sometext'
  end

#   it 'should compose email notifications' do
#     expect(manager.email_notification). to eq <<-TEXT
# Hello, some code!

# You should return a book "some code" authored by some code in some code hours.
# Otherwise you will be charged $some code per hour. 
# TEXT
#   end
  
end
