require './library_manager.rb'

describe LibraryManager do

  let(:leo_tolstoy) do
    Author.new(1828, 1910, 'Leo Tolstoy' ) 
  end
  let(:oscar_wilde) { Author.new(1854, 1900, 'Oscar Wilde') }
  let(:war_and_peace) { PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) }
  let(:ivan_testenko) { ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) }
  let(:manager) { LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) }

  it 'should count penalty' do
    res = manager.penalty
#      ((0,00007 * (2015-1996))) + 
#      (0,000003 * 3280) + 
#      (0,0005) * 1400 * 48
    expect(res).to eq 784 
  end

  it 'should know if author can meet another author' do
    res = manager.could_meet_each_other? leo_tolstoy, oscar_wilde
    expect(res).to eq true
  end  

  it 'should count days to buy' do
    res = manager.days_to_buy
    #1 / 0,01167 / 24
    expect(res).to eq 4
  end

  it 'should transliterate ukrainian names' do
    ukrainan_author = Author.new(1856, 1916, 'Іван Франко')
    res = manager.transliterate ukrainan_author
    expect(res).to eq "Ivan Franko"
  end

  it 'should count penalty to finish' do
    res = manager.penalty_to_finish
    #1400 * 0.001 * 48
    #0.01167 * 1400 * 185
    expect(res).to eq 3790
  end

  it 'should compose email notifications' do
#    expect(manager.email_notification). to eq <<-TEXT
#Hello, some code!

#You should return a book "some code" authored by some code in some code hours.
#Otherwise you will be charged $some code per hour. 
#TEXT
  end
  
end
