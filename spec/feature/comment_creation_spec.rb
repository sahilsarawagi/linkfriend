# TODO: Add comments
require "rails_helper"

RSpec.feature "Create comment", :type => :feature, js: true do
  let(:user) { create(:user) } 
  let(:post) { create(:post, user: user)}

  before do
    login_as(user, scope: :user)
    visit root_path
    create(:post, user: user)
    find("#commentButton").click
  end
  
  scenario 'Create comment on post' do
    
  end

  
end
