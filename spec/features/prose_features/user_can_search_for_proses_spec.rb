require 'spec_helper'

feature 'A visitor can search for a specific story', %q{
    As an user
    I want to be able to browse a list of user proses
    So that I can select a prose to beta edit
} do

  let!(:molly) {FactoryGirl.create(:user, username:'woopwoop')}
  let(:fanfic) {FactoryGirl.create(:prose, user_id:molly.id, title:'hi')}

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
    expect(page).to have_content('Sorry, there were no matches.')

  end

end
