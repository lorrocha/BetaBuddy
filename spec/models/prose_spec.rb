require 'spec_helper'

describe Prose do
  #Validation tests
  it {should have_valid(:user_id).when(1, 2343535)}
  it {should_not have_valid(:user_id).when(nil, 'heeeyo', '')}
  it {should have_valid(:description).when('do you believe in a thing called love?', 'I dreamed a dream')}
  it {should_not have_valid(:description).when(nil, '')}
  it {should have_valid(:current_state).when('1', '2343535', 23)}
  it {should_not have_valid(:current_state).when(nil, 'love', '')}

  #relationship tests
  it {should have_many(:prose_tags)}
  it {should have_many(:genres)}

  let(:prose) {FactoryGirl.create(:prose)}
  let(:genre1) {FactoryGirl.create(:genre)}
  let(:genre2) {FactoryGirl.create(:genre)}

  it 'Should have multiple genres in relationship to it' do
    ProseTag.create(prose_id:prose.id, genre_id:genre1.id)
    ProseTag.create(prose_id:prose.id, genre_id:genre2.id)
    expect(prose.genres.count).to eql(2)
  end
end