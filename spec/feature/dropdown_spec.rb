require "rails_helper"

RSpec.feature "Dropdown functioning", :type => :feature, js: true do
  let(:user) { create(:user) } 

  before do
    login_as(user, scope: :user)
    visit root_path
  end
  
  scenario 'Opening and closing dropdown on big screen size ' do
    # opening on big screen
    Capybara.current_session.driver.browser.manage.window.resize_to(1366, 768)

    # check if the dropdown is not open 
    expect_dropdown_to_be_closed('user-dropdown')
    # opening the dropdown
    open_dropdown('user-menu-button')
    # check if the dropdown is open
    expect_dropdown_to_be_open('user-dropdown')
    # closing the dropdown by clicking outside
    page.find('body').click
    # check if the dropdown is not open
    expect_dropdown_to_be_closed('user-dropdown')
    # opening the dropdown
    open_dropdown('user-menu-button')
    # check if the dropdown is open
    expect_dropdown_to_be_open('user-dropdown')
    # closing the dropdown by clicking on the dropdown menu
    close_dropdown('user-menu-button')
    # check if the dropdown is not open
    expect_dropdown_to_be_closed('user-dropdown')
    
  end

  scenario 'Opening and closing dropdown on small screen size ' do
    
    # opening on small screen
    Capybara.current_session.driver.browser.manage.window.resize_to(375, 667)
    visit current_path
    # check if the dropdown is not open 
    expect_dropdown_to_be_closed('navbar-user')
    # opening the dropdown
    open_dropdown('user-menu-nav')
    # check if the dropdown is open
    expect_dropdown_to_be_open('navbar-user')
    # closing the dropdown by clicking outside
    click_button 'Post'
    # check if the dropdown is not open
    expect_dropdown_to_be_closed('navbar-user')
    # opening the dropdown
    open_dropdown('user-menu-nav')
    # check if the dropdown is open
    expect_dropdown_to_be_open('navbar-user')
    # closing the dropdown by clicking on the dropdown menu
    close_dropdown('user-menu-nav')
    # check if the dropdown is not open
    expect_dropdown_to_be_closed('navbar-user')    
  end


  def open_dropdown(id_selector)
    find("##{id_selector}").click
  end

  def close_dropdown(id_selector)
    find("##{id_selector}").click
  end

  def expect_dropdown_to_be_open(id_selector)
    expect(page).to have_selector("##{id_selector}", wait: 5)
  end

  def expect_dropdown_to_be_closed(id_selector)
    expect(page).to have_no_selector("##{id_selector}", wait: 5)
  end
  
end
