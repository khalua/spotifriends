require 'spec_helper'
require 'features/shared/login_helper'
include LoginHelper

describe 'User' do
  describe 'GET /users/show' do
    let(:user) {FactoryGirl.create(:user0)}

    it 'displays a page with the users preferences and groups' do
      login_to_system(user)
      click_link('Edit profile')
      page.should have_button('Update')
    end
  end
end