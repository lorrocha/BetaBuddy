require 'spec_helper'

describe ProseTag do
  #Relationship tests
  it {should belong_to(:genre)}
  it {should belong_to(:prose)}
end
