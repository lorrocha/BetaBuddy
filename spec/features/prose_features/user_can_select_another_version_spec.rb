require 'spec_helper'

feature 'User can select which version they choose to see' do

  let(:molly){FactoryGirl.create(:user)}
  let(:prose){FactoryGirl.create(:prose, user_id:molly.id)}

  def sign_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end


  scenario 'The latest version always renders first' do
    visit user_prose_path(prose.user,prose)

    expect(page).to have_content(prose.description)
  end

  scenario 'When an edit is made then the page populates the version dropdown' do
    with_versioning do
      sign_in(molly)
      old_desc = 'Daaaamn girl u fine'
      new_desc = 'Gimme dat TOOT TOOT TOOOOTTT'

      visit 'proses/new'
      fill_in 'Title', with: 'Best Title Ever'
      fill_in 'Story', with: old_desc
      click_button 'Create Prose'

      expect(page).to have_content(old_desc)
      click_on 'Edit'

      fill_in "Story", with: new_desc
      click_button "Edit Prose"

      select 1, from: 'Version'
      expect(page).to have_content(new_desc)
    end
  end

  scenario 'multiple edits can be made' do
    with_versioning do
      sign_in(molly)

      visit user_prose_path(prose.user,prose)
      click_on 'Edit'
      fill_in 'Story', with: 'wooooo'
      click_button 'Edit Prose'

      click_on 'Edit'
      fill_in 'Story', with: 'ahasndjwedoooo'
      click_button 'Edit Prose'

      find_field('Version').should have_content(2)

    end
  end
end
