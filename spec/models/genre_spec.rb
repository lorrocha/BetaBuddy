require 'spec_helper'

describe Genre do
  it {should have_valid(:name).when('Humor', 'Erotica')}
  it {should_not have_valid(:name).when(nil, '')}
end
