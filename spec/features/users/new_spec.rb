require 'rails_helper'

RSpec.describe 'new user vew' do
  it 'has a form to register a new user' do
    visit register_path

    fill_in 'user_email', with: 'User@email.com'
    fill_in 'user_name', with: 'User Name'
    fill_in 'user_password', with: '12345'
    fill_in 'user_password_confirmation', with: '12345'

    click_on 'Register'

    expect(current_path).to eq(user_path(User.first))
    expect(User.first.name).to eq('User Name')
  end
  it 'wont register an invalid user' do
    visit register_path

    fill_in 'user_email', with: ''
    fill_in 'user_name', with: ''

    click_on 'Register'
    within '.error-msgs' do
      expect(page).to have_content(/Name can't be blank Email can't be blank/)
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Password confirmation can't be blank")
    end
  end
  it 'wont register a user with the same email' do
    user = User.create!(name: 'bill', email: 'Billy@gmail.com', password: '12345', password_confirmation: '12345')
    visit register_path

    fill_in 'user_email', with: 'billy@gmail.com'
    fill_in 'user_name', with: 'BILL'
    fill_in 'user_password', with: '12345'
    fill_in 'user_password_confirmation', with: '12345'

    click_on 'Register'
    within '.error-msgs' do
      expect(page).to have_content('Email has already been taken')
    end
  end
end
