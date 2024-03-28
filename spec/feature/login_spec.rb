require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user logs in and is redirected back to the root page', js: true do
    visit root_path
    expect(page).to have_current_path(new_user_session_path)

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Sign in'

    expect(page).to have_current_path(root_path)
    # expect(page).to have_content('You are logged in!')
  end

end
