require 'spec_helper'

describe 'Request' do
  describe 'GET /requests/new' do
    it 'Lets user sign up for an account' do
      visit root_path
      click_link('Sign up')
      fill_in('Email', :with => 'tony.contreras@gmail.com')
      fill_in('Password', :with => '12345678')
      fill_in('Password confirmation', :with => '12345678')
      click_button('Sign up')
      page.should have_text('Welcome')
    end
  end
end
