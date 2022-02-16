require 'rails_helper'

RSpec.describe 'landing page' do
  it 'has an application title' do
    user_1 = User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345',
                         password_confirmation: '12345')
    user_2 = User.create(name: 'will cob', email: 'cob21@gmail.com', password: '12345',
                         password_confirmation: '12345')

    user_3 = User.create(name: 'sill cob', email: 'cob34@gmail.com', password: '12345',
                         password_confirmation: '12345')
    visit root_path
    within '.title' do
      expect(page).to have_content('Viewing Page Party')
    end

    within '.all-users' do
      expect(page).to have_link(user_1.name)
      expect(page).to have_link(user_2.name)
      expect(page).to have_link(user_3.name)

      click_link(user_1.name)

      expect(current_path).to eq(user_path(user_1))
    end

    visit root_path
    within '.new-user' do
      click_button 'Register'
      expect(current_path).to eq(register_path)
    end
  end
  describe 'Log In Path' do
    it 'has a link to log in a user' do
      visit root_path

      within '.log-in' do
        click_link 'Log In'

        expect(current_path).to eq(login_path)
      end
    end
  end
end
