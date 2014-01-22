require 'spec_helper'

feature 'A visitor can search for a specific story', %q{
    As an user
    I want to be able to browse a list of user proses
    So that I can select a prose to beta edit
} do

  let!(:molly) {FactoryGirl.create(:user, username:'woopwoop')}
  let(:fanfic) {FactoryGirl.create(:prose, user_id:molly.id, title:'hi')}
  let(:genre) {FactoryGirl.create(:genre)}
  let(:wrong_prose) {FactoryGirl.create(:prose, title:'BLEEP')}

  scenario 'A user can search for a prose by author content' do
    Prose.destroy_all
    fanfic
    FactoryGirl.create(:prose)

    visit '/search'
    fill_in 'Search', with: molly.username
    click_button 'Search'

    expect(page).to have_content('hi')
  end

  scenario 'A user can search for a prose by title content' do
    Prose.destroy_all
    fanfic
    FactoryGirl.create(:prose)

    visit '/search'
    fill_in 'Search', with: "hi"
    click_button 'Search'

    expect(page).to have_content('hi')
  end

  scenario 'A notice comes back if there are no viable matches' do
    visit '/search'
    fill_in 'Search', with: "woops"
    click_button 'Search'

    expect(page).to_not have_content('woops')
    expect(page).to have_content('Oh no! There were no matches. Why not make your own?')
  end

  scenario 'A user can search for a prose by genre' do
    Prose.destroy_all
    fanfic.prose_tags.build(genre_id:genre.id).save!

    visit '/search'
    select genre.name, from: 'Genre'
    click_button 'Search'
    expect(page).to have_content(fanfic.title)
  end

  scenario 'A user can search for a prose by genre and text' do
    Prose.destroy_all
    fanfic.prose_tags.build(genre_id:genre.id).save!
    wrong_prose.prose_tags.build(genre_id:genre.id).save!

    visit '/search'
    fill_in 'Search', with: fanfic.title
    select genre.name, from: 'Genre'
    click_button 'Search'

    expect(page).to have_content(fanfic.title)
    # expect(page).to_not have_content(wrong_prose.title)
  end

end
