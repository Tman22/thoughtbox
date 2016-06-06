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

      expect(current_path).to eq "/links"
      expect(page).to have_content 'Sign Out'
      expect(page).to have_content "Welcome #{user.name}!"

      click_on 'Sign Out'

      expect(current_path).to eq '/'
    end

    it 'does not create account password error' do

      visit '/users/new'
      fill_in 'Name', with: 'Bruce'
      fill_in 'Email', with: 'darkness@batcave.com'
      fill_in 'Password', with: 'Rough'
      fill_in 'Password confirmation', with: 'RoughLife20'
      click_on 'Create'

      expect(current_path).to eq "/users"
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    it 'does not create account email error' do
      User.create(name: 'Robin', email: 'darkness@batcave.com', password: 'sidekick101')
      visit '/users/new'
      fill_in 'Name', with: 'Bruce'
      fill_in 'Email', with: 'darkness@batcave.com'
      fill_in 'Password', with: 'Rough'
      fill_in 'Password confirmation', with: 'RoughLife20'
      click_on 'Create'

      expect(current_path).to eq "/users"
      expect(page).to have_content "Email has already been taken"
    end
  end
end
