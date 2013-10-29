require 'spec_helper'
require 'features/shared/login_helper'
include LoginHelper

describe 'Session' do
  describe 'GET /' do
    it 'displays a login link' do
      visit root_path
      page.should have_link('Login')
    end
  end

  describe 'POST /login' do
    let(:user) {FactoryGirl.create(:user0)}

    it 'logs the user into the system if the creds are correct' do
      login_to_system(user)
      page.should_not have_link('Beta login')
    end
    it 'does not allow user to log in with bad creds' do
      visit root_path
      click_link('Login')
      fill_in('Email', :with => user.email)
      fill_in('Password', :with => 'POOP')
      click_button('Sign in')
      page.should have_button('Sign in')
    end
  end

  describe 'DELETE /login', js: true do
    let(:user) {FactoryGirl.create(:user0)}

    it 'logs the user of the system' do
      login_to_system(user)
      click_link('Logout')
      # page.driver.browser.switch_to.alert.accept
      page.should have_link('Sign up')
    end
  end
end
