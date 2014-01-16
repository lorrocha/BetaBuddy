require 'spec_helper'

describe Quote do
  it 'gives you a random quote!' do
    quote = FactoryGirl.create(:quote)
    expect(Quote.random).to eql(quote)
  end
end
