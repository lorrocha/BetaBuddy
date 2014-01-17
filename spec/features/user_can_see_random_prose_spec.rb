require 'spec_helper'

feature 'A user can be linked to a random prose', %q{
    As a user
    I want to be able to be given a random prose
    So that I can be surprised with the variety of the prose content
} do

  let!(:prose) {FactoryGirl.create(:prose)}

  scenario 'Anyone can see the button in the nav bar' do
    visit root_path

    expect(page).to have_content('Feeling Lucky?')
  end

  scenario 'Upon clicking on the button, they are taken to the random prose' do
    visit root_path
    first(:link, 'Feeling Lucky?').click

    expect(page).to have_content(prose.title)
    expect(page).to have_content(prose.description)
  end
end
