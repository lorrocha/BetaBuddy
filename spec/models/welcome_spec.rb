require 'spec_helper'

describe Welcome do
  it 'holds a database of inspirational quotes' do
    expect(Welcome.quotes).to include({"Oscar Wilde"=>"Be yourself; everyone else is already taken."})
  end
end
