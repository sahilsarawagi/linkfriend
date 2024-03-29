require "rails_helper"

RSpec.feature "Creating Post", :type => :feature do
  let(:user) { create(:user) } 

  before do
    login_as(user, scope: :user)
    visit root_path
  end
  
  scenario 'User creates a new post without photo' do
    # Fill in the form fields
    fill_in 'post-box', with: 'Lorem ipsum dolor sit amet.'

    # Submit the form
    click_button 'Post'

    # Expectations
    # expect(page).to have_content('Post was successfully created.')
    post = Post.last
    within "#post-id-#{post.id}" do
      expect(page).to have_content('Lorem ipsum dolor sit amet.')
      expect(page).to have_content(user.first_name.capitalize)
      expect(page).to have_content(user.last_name.capitalize)
      expect(page).to have_content(post.updated_at.strftime("%B %d, %Y"))
      expect(page).not_to have_selector(".post-image")
    end
  end

  scenario 'User creates a new post with photo' do
    fill_in 'post-box', with: 'Lorem ipsum'
  
    attach_file('photo-upload', Rails.root.join('spec/fixtures/sample.jpeg')) # Attach a photo
  
    click_button 'Post'
  
    post = Post.last
    within "#post-id-#{post.id}" do
      expect(page).to have_content('Lorem ipsum')
      expect(page).to have_content(user.first_name.capitalize)
      expect(page).to have_content(user.last_name.capitalize)
      expect(page).to have_content(post.updated_at.strftime("%B %d, %Y"))
      expect(page).to have_selector(".post-image")
    end
  end
end
