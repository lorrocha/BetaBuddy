require 'spec_helper'

describe Genre do
  #Validation tests
  it {should have_valid(:name).when('Humor', 'Erotica')}
  it {should_not have_valid(:name).when(nil, '')}

  #relationship tests
  it {should have_many(:prose_tags)}
  it {should have_many(:proses)}

  it 'Should have multiple proses in relationship to it' do
    prose1 =FactoryGirl.create(:prose)
    prose2 = FactoryGirl.create(:prose)
    genre = FactoryGirl.create(:genre)

    ProseTag.create(prose_id:prose1.id, genre_id:genre.id)
    ProseTag.create(prose_id:prose2.id, genre_id:genre.id)
    expect(genre.proses.count).to eql(2)
  end
end
