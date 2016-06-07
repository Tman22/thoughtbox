require 'rails_helper'

RSpec.describe 'User can change status' do
  include Capybara::DSL
  context 'user has links' do
    it 'and can change status to read or unread', js: true do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')
      link = Link.create(title: 'Cool', url: 'http://www.youtube.com')
      user.links << link
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/links'

      expect(page).to have_content "Cool"
      expect(page).to have_button "Mark as Unread"

      click_on 'Mark as Unread'

      expect(page).to have_button "Mark as Read"

      click_on 'Mark as Read'

      expect(page).to have_button "Mark as Unread"

    end
  end
end
