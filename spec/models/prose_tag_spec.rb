require 'spec_helper'

describe ProseTag do
  #Validations tests
  it {should have_valid(:prose_id).when(1,234435)}
  it {should_not have_valid(:prose_id).when(nil, '', 'one')}

  #Relationship tests
  it {should belong_to(:genre)}
  it {should belong_to(:prose)}
end
