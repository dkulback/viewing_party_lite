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
        expect(page).to have_content('Viewing Page Party')
      end

      within '.new-user' do
        click_button 'Register'
        expect(current_path).to eq(register_path)
      end
    end
  end
  describe 'Log In Path' do
    user_2 = User.create(name: 'will cob', email: 'cob21@gmail.com', password: '12345',
                         password_confirmation: '12345')
    it 'has a link to log in a user' do
      visit root_path

      within '.log-in' do
        click_link 'Log In'

        expect(current_path).to eq(login_path)
      end
    end
    it 'wont let you go to a dashboard_path' do
      visit dashboard_path

      within '.alert' do
        expect(page).to have_content('Must be logged in!')
      end
    end
  end
  describe 'logged in user' do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user_1)
    end
    it 'doesnt have links to log in a user but has log out links' do
      visit root_path

      expect(page).to_not have_link('Log In')
      within '.log-out' do
        click_link 'Log Out'

        expect(current_path).to eq(root_path)
      end
    end
    it 'has a list of users emails' do
      user_2 = User.create!(name: 'William', email: 'email', password: '1', password_confirmation: '1')
      user_3 = User.create!(name: 'William', email: 'gmail', password: '1', password_confirmation: '1')
      visit root_path

      within '.users' do
        expect(page).to have_content(user_2.email)
        expect(page).to have_content(user_3.email)
      end
    end
  end
end
