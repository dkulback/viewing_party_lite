require 'rails_helper'

RSpec.describe 'users index page' do
  describe 'has a list of users and links to their profiles' do
    let(:user) do
      User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
    end

    before(:each) do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
    end
    context 'when a user is logged in' do
      it 'shows a list of current users' do
        User.create(name: 'will mob', email: 'mob39@gmail.com', password: '12345', password_confirmation: '12345')
        User.create(name: 'aill bob', email: 'bob39@gmail.com', password: '12345', password_confirmation: '12345')
        visit users_path
        within '.header' do
          expect(page).to have_content('Current Users Watching Great Movies')
        end
        within '.users' do
          expect(page).to_not have_link('bill cob')
          expect(page).to have_link('will mob')
          expect(page).to have_link('aill bob')
          expect(page).to have_button('Add User')
          click_on(class: "users-#{User.last.id}")

          expect(page).to_not have_content('aill bob')
          expect(current_path).to eq(users_path)
        end
        within '.notice' do
          expect(page).to have_content('Friend Request Sent!')
        end
      end
    end
  end
end
