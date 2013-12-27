require 'spec_helper'

describe Prose do
  #Validation tests
  it {should have_valid(:user_id).when(1, 2343535)}
  it {should_not have_valid(:user_id).when(nil, 'heeeyo', '')}
  it {should have_valid(:description).when('do you believe in a thing called love?', 'I dreamed a dream')}
  it {should_not have_valid(:description).when(nil, '')}
  it {should have_valid(:current_state).when('1', '2343535', 23)}
  it {should_not have_valid(:current_state).when(nil, 'love', '')}
end
