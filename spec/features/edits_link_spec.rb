require 'rails_helper'

RSpec.describe 'User can edit a link' do
  include Capybara::DSL
  context 'User has a link' do
    it 'clicks edit and update' do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')
      link = Link.create(title: 'Cool', url: 'http://www.youtube.com')
      user.links << link
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/'

      expect(current_path).to eq '/links'
      click_on 'Edit'

      expect(current_path).to eq "/links/#{link.id}/edit"

      fill_in 'Title', with: 'Sweet'
      fill_in 'Url', with: 'http://www.google.com'
      click_on 'Update'

      expect(current_path).to eq '/links'
      expect(Link.all.count).to eq 1
      expect(page).to have_content 'Sweet'
      expect(page).to have_content 'http://www.google.com'
      expect(page).to have_button 'Mark as Unread'

    end

    it 'does not edit because bad url' do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')
      link = Link.create(title: 'Cool', url: 'http://www.youtube.com')
      user.links << link
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/'

      expect(current_path).to eq '/links'
      click_on 'Edit'

      expect(current_path).to eq "/links/#{link.id}/edit"

      fill_in 'Title', with: 'Sweet'
      fill_in 'Url', with: 'sweet-sauce-piggy.com'
      click_on 'Update'

      expect(current_path).to eq "/links/#{link.id}"
      expect(Link.all.count).to eq 1
      expect(page).to have_content "Please put in a valid URL!"

    end

  end
end
