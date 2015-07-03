require './library_manager.rb'

describe LibraryManager do

  let(:leo_tolstoy) { Author.new(1828, 1910, 'Leo Tolstoy' ) }
  let(:oscar_wilde) { Author.new(1854, 1900, 'Oscar Wilde') }
  let(:war_and_peace) { PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) }
  let(:ivan_testenko) { ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) }
  let(:manager) { LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) }

  it 'should count penalty' do
    # manager.penalty  780
    expect(manager.penalty).to eq 780
  end

  it 'should know if author can meet another author' do
    # manager.could_meet_each_other? leo_tolstoy, oscar_wilde
    expect(manager.could_meet_each_other? leo_tolstoy, oscar_wilde).to eq true
  end  

 it 'should know if author can meet another author' do
    # manager.could_meet_each_other? leo_tolstoy, oscar_wilde
    author1 = Author.new(1828, 1853, 'Leo Tol' ) 
    author2 = Author.new(1854, 1900, 'Oscar Wi')
    expect(manager.could_meet_each_other? author1, author2).to eq false
  end  

  it 'should count days to buy' do
    # manager.days_to_buy
    expect(manager.days_to_buy).to eq 4
  end

  it 'should transliterate ukrainian names' do
    ukrainan_author = Author.new(1856, 1916, 'Іван Франко')
    # manager.transliterate ukrainan_author
    expect(manager.transliterate ukrainan_author).to eq 'Ivan Franko'
  end

  it 'should count penalty to finish' do
    # manager.penalty_to_finish
    expect(manager.penalty_to_finish).to eq 3768
  end
  
end
