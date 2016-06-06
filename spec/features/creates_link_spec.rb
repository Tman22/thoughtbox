require 'rails_helper'

RSpec.describe 'User can create a link' do
  include Capybara::DSL
  context 'sees only their links' do
    it 'creates link' do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')

      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/'

      expect(current_path).to eq '/links'

      fill_in 'Title', with: 'Cool'
      fill_in 'Url', with: 'http://www.youtube.com'
      click_on 'Create Link'

      expect(current_path).to eq '/links'
      expect(Link.all.count).to eq 1


    end

    it 'creates does not create link' do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')

      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/links'

      fill_in 'Title', with: 'Cool'
      fill_in 'Url', with: 'Nah'
      click_on 'Create Link'

      expect(current_path).to eq '/links'
      expect(Link.all.count).to eq 0
      expect(page).to have_content "Please put in a valid URL!"

    end

  end
end
