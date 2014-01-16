require 'spec_helper'

describe ProseTag do
  #Relationship tests
  it {should belong_to(:genre)}
  it {should belong_to(:prose)}

  let(:prose) {FactoryGirl.create(:prose)}
  let!(:genre) {FactoryGirl.create(:genre)}

  it 'is destroyed when the prose is' do
    ProseTag.destroy_all
    prose.prose_tags.build(genre_id: genre.id).save
    prose_tag = prose.prose_tags.first
    expect(ProseTag.count).to be(1)

    prose.destroy
    expect(Prose.where(id:prose.id)).to be_empty
    expect(ProseTag.where(id:prose_tag.id)).to be_empty
    expect(ProseTag.count).to eql(0)
  end

  it 'is destroyed when the genre is' do
    ProseTag.destroy_all
    genre.prose_tags.build(prose_id: prose.id).save!
    prose_tag = prose.prose_tags.first
    expect(ProseTag.count).to be(1)

    genre.destroy
    expect(Genre.where(id:genre.id)).to be_empty
    expect(ProseTag.where(id:prose_tag.id)).to be_empty
    expect(ProseTag.count).to eql(0)
  end
end
