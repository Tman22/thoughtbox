require 'rails_helper'

RSpec.describe 'User goes to root page' do
  include Capybara::DSL
  context 'user sees sign in' do
    it 'and signs in' do

      visit '/'

      expect(page).to have_link 'Sign In'
    end

    it 'clicks on sign in' do

      visit '/'
      click_on 'Sign In'

      expect(current_path).to eq '/users/new'
    end

    it 'and creates account then signs out' do

      visit '/users/new'
      fill_in 'Name', with: 'Bruce'
      fill_in 'Email', with: 'darkness@batcave.com'
      fill_in 'Password', with: 'RoughLife20'
      fill_in 'Password confirmation', with: 'RoughLife20'
      click_on 'Create'

      expect(User.all.count).to eq 1
      user = User.first

      expect(current_path).to eq "/users/#{user.id}"
      expect(page).to have_content 'Sign Out'

      click_on 'Sign Out'

      expect(current_path).to eq '/'
    end
  end
end
