require 'rails_helper'

RSpec.describe 'landing page' do
  let(:user_1) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  describe 'when a user is logged in' do
    it 'has an application title' do
      user_2 = User.create(name: 'will cob', email: 'cob21@gmail.com', password: '12345',
                           password_confirmation: '12345')

      user_3 = User.create(name: 'sill cob', email: 'cob34@gmail.com', password: '12345',
                           password_confirmation: '12345')
      visit root_path
      within '.title' do
        expect(page).to have_content('Viewing Party!')
      end

      within '.new-user' do
        click_link 'Register'
        expect(current_path).to eq(register_path)
      end
    end
  end
  describe 'Log In Path' do
    user_2 = User.create(name: 'will cob', email: 'cob21@gmail.com', password: '12345',
                         password_confirmation: '12345')
    it 'has a link to log in a user' do
      visit root_path

      within '.links' do
        click_link 'Login'

        expect(current_path).to eq(login_path)
      end
    end
    it 'wont let you go to a dashboard_path' do
      visit dashboard_path
      within '.user' do
        expect(page).to have_content('Must be logged in!')
      end
    end
  end
  describe 'logged in user' do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user_1)
    end
    it 'has a link in the navbar to browse other users' do
      visit root_path
      within '.links' do
        expect(page).to have_link('Browse Users')
      end
    end
    it 'doesnt have links to log in a user but has log out links' do
      visit root_path

      expect(page).to_not have_link('Log In')
      within '.links' do
        click_link 'Logout'

        expect(current_path).to eq(root_path)
      end
    end
  end
end
