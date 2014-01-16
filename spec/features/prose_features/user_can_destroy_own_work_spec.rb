require 'spec_helper'

feature 'Owner of the prose can destroy his own prose', %q{
    As a user
    I want to destroy my own work
    So that I'm not embarrassed forever by it
} do


  let(:molly) {FactoryGirl.create(:user)}
  let(:fanfic) {FactoryGirl.create(:prose, user_id:molly.id)}

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  scenario 'A user can destroy their own work' do
    sign_in(molly)
    visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
    expect(page).to have_content('Delete')

    click_on 'Delete'
    expect(page).to have_content("#{fanfic.title} has been deleted.")
  end

  scenario 'A user cannot destroy anothers work' do
    sally = FactoryGirl.create(:user)
    sign_in(sally)
    visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
    expect(page).to_not have_content('Delete')
  end

  scenario 'An unauthenticated user cannot see the link' do
    visit "/users/#{fanfic.user_id}/proses/#{fanfic.id}"
    expect(page).to_not have_content('Delete')
  end
end
