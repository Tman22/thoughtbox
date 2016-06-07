RSpec.describe 'User can search by title' do
  include Capybara::DSL
  context 'user has links' do
    it 'can search for title', js: true do
      user = User.create(name: 'Taylor', email: 'awesomesauce@cool.net', password: 'password')
      link = Link.create(title: 'Cool', url: 'http://www.youtube.com')
      link2 = Link.create(title: 'Sweet', url: 'http://www.youtube.com')
      user.links << link
      user.links << link2
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit '/links'

      fill_in 'Search', with: 'cool'

      expect(page).to have_content 'Cool'

      fill_in 'Search', with: 'sweet'

      expect(page).to have_content 'Sweet'

    end
  end
end
