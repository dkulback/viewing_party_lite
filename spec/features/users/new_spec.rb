require 'rails_helper'

RSpec.describe 'new user vew' do
  it 'has a form to register a new user' do
    visit register_path

    fill_in 'email', with: 'User@email.com'
    fill_in 'user_name', with: 'User Name'
    fill_in 'user_password', with: '12345'
    fill_in 'user_password_confirmation', with: '12345'

    click_on 'Register'

    expect(current_path).to eq(dashboard_path)
    expect(User.first.name).to eq('User Name')
  end
  it 'wont register an invalid user blank user name and email' do
    visit register_path

    fill_in 'email', with: ''
    fill_in 'user_name', with: ''

    click_on 'Register'
    within '.user_errors' do
      expect(page).to have_content("User Not Registered: Name can't be blank, Email can't be blank, Password Please enter a password, it can not be blank., Password confirmation Please type the same password to confirm password.")
    end
  end
  it 'wont register a user with the same email' do
    user = User.create!(name: 'bill', email: 'Billy@gmail.com', password: '12345', password_confirmation: '12345')
    visit register_path

    fill_in 'email', with: 'billy@gmail.com'
    fill_in 'user_name', with: 'BILL'
    fill_in 'user_password', with: '12345'
    fill_in 'user_password_confirmation', with: '12345'

    click_on 'Register'
    within '.user_errors' do
      expect(page).to have_content('Email has already been taken')
    end
  end
  it 'wont register a user with passwords that dont match' do
    visit register_path

    fill_in 'email', with: 'billy@gmail.com'
    fill_in 'user_name', with: 'BILL'
    fill_in 'user_password', with: '1235'
    fill_in 'user_password_confirmation', with: '12345'

    click_on 'Register'
    within '.user_errors' do
      expect(page).to have_content('Passwords must be matching!')
    end
  end
end
