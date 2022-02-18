require 'rails_helper'

RSpec.describe 'users login form' do
  describe 'it has a login form with password/email' do
    context 'when the user has valid credentials' do
      it 'logs the user in' do
        user = User.create!(name: 'billy', email: 'email@gmail.com', password: '12345', password_confirmation: '12345')
        visit login_path
        within '.login-form' do
          fill_in 'email', with: 'email@gmail.com'
          fill_in 'password', with: '12345'

          click_on 'Log In'

          expect(current_path).to eq(user_path(user))
        end
        within '.success' do
          expect(page).to have_content("Welcome #{user.name}!")
        end
      end
    end
    context 'when password is invalid' do
      it 'renders a flash massage invalid password' do
        user = User.create!(name: 'billy', email: 'email@gmail.com', password: '12345', password_confirmation: '12345')
        visit login_path
        within '.login-form' do
          fill_in 'email', with: 'email@gmail.com'
          fill_in 'password', with: '1234523981111'

          click_on 'Log In'

          expect(current_path).to eq(login_path)
        end
        within '.invalid_password' do
          expect(page).to have_content('Invalid Password')
        end
      end
    end
    context 'when email in invalid' do
      it 'has an error message invalid email' do
        user = User.create!(name: 'billy', email: 'email@gmail.com', password: '12345', password_confirmation: '12345')
        visit login_path
        within '.login-form' do
          fill_in 'email', with: 'email@ymail.com'
          fill_in 'password', with: '1234523981111'

          click_on 'Log In'

          expect(current_path).to eq(login_path)
        end
        within '.invalid_email' do
          expect(page).to have_content("Couldn't find user with email email@ymail.com")
        end
      end
    end
  end
end
