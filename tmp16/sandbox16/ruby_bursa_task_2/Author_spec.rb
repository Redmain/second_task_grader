require './author.rb'
require 'active_support/all'
require 'pry'

describe author do

  context '#name' do

    it 'name' do
      name = "ivan"

      res = Author.new.name(name)

      expect(res).to eq ivan
    end
end
end