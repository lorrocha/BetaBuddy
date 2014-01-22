require 'spec_helper'

feature 'A visitor to the site can see the current memberlist' do

  let!(:user) {FactoryGirl.create(:user)}
  let!(:fanfic) {FactoryGirl.create(:prose, user_id:user.id, title:'hi')}

  scenario 'A user can visit the users path from the nav bars' do
    visit root_path
    first(:link, 'Members').click

    expect(page).to have_content(user.username)
  end

  scenario ' A user can click on the user and get taken to the user path' do
    visit root_path
    first(:link, 'Members').click
    click_on user.username

    expect(page).to have_content(fanfic.title)
  end

end
