require 'spec_helper'

describe Prose do
  #Validation tests
  it {should have_valid(:user_id).when(FactoryGirl.create(:user))}
  it {should have_valid(:description).when('do you believe in a thing called love?', 'I dreamed a dream')}
  it {should_not have_valid(:description).when(nil, '')}
  #relationship tests
  it {should have_many(:prose_tags)}
  it {should have_many(:genres)}

  let(:prose) {FactoryGirl.create(:prose)}
  let!(:genre1) {FactoryGirl.create(:genre)}
  let!(:genre2) {FactoryGirl.create(:genre)}

  it 'Should have multiple genres in relationship to it' do

    ProseTag.create(prose_id:prose.id, genre_id:genre1.id)
    ProseTag.create(prose_id:prose.id, genre_id:genre2.id)
    expect(prose.genres.count).to eql(2)
  end

  it 'can be searched and returned' do
    Prose.destroy_all
    prose
    tester = 'Dance baby dance!'
    FactoryGirl.create(:prose, title:tester)

    expect(Prose.search(tester, nil).count).to eql(1)
  end

  it 'can be searched and returned by genre' do
    Prose.destroy_all
    FactoryGirl.create(:prose)

    prose.prose_tags.build(genre_id:genre1.id).save!
    expect(prose.genres).to include(genre1)
    expect(Prose.count).to eql(2)

    expect(Prose.search(nil, genre1.id).count).to eql(1)
  end

  it 'can be searched and returned by both text and genre' do
    Prose.destroy_all
    title = 'Gone with the wind'
    FactoryGirl.create(:prose, title: title)
    test = FactoryGirl.create(:prose, title: title)

    prose.prose_tags.build(genre_id:genre1.id).save!
    test.prose_tags.build(genre_id:genre1.id).save!

    expect(Prose.search(title, nil).count).to eql(2)
    expect(Prose.search(nil, genre1.id).count).to eql(2)
    expect(Prose.search(title, genre1.id).count).to eql(1)
  end

  it 'can return a randomized prose element' do
    Prose.destroy_all
    prose

    expect(Prose.random_prose).to eql(prose)
  end

end
