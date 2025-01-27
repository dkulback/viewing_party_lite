require 'rails_helper'
RSpec.describe 'new viewing party page' do
  let(:user_1) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user_1)
  end
  it 'has title and form' do
    user_2 = User.create(name: 'cob', email: 'cob39@gml.com', password: '12345', password_confirmation: '12345')
    VCR.use_cassette('your_eyes_tell_new') do
      visit new_movie_party_path('730154')
      within '.new-party-form' do
        expect(page).to have_content('Your Eyes Tell')
        fill_in 'Duration', with: 130
        select '2022', from: '_date_1i'
        select 'February', from: '_date_2i'
        select '6', from: '_date_3i'
        select '7 PM', from: '_time_4i'
        select '45', from: '_time_5i'
        check("invites_#{user_2.id}")
        expect(page).to have_button('Create Party')
        click_button('Create Party')
        expect(current_path).to eq(dashboard_path)
      end
    end
  end
  it 'wont let duration of the party be shorter than runtime of the movie', :vcr do
    user_2 = User.create(name: 'cob', email: 'cob39@gml.com', password: '12345', password_confirmation: '12345')
    visit new_movie_party_path('730154')
    within '.new-party-form' do
      fill_in 'Duration', with: 122
      select '2022', from: '_date_1i'
      select 'February', from: '_date_2i'
      select '6', from: '_date_3i'
      select '7 PM', from: '_time_4i'
      select '45', from: '_time_5i'
      check("invites_#{user_2.id}")

      click_button('Create Party')
    end
    within '.duration' do
      expect(page).to have_content(/Duration can't be shorter than movies runtime./)
      expect(current_path).to eq(new_movie_party_path('730154'))
    end
  end

  it 'invites users to the party that are checked off in form' do
    VCR.use_cassette('new_movie_cassette') do
      user_2 = User.create(name: 'cob', email: 'cob39@gml.com', password: '12345', password_confirmation: '12345')
      user_3 = User.create!(name: 'billy', email: 'email@gm4il.com', password: '12345', password_confirmation: '12345')
      user_4 = User.create!(name: 'billy', email: 'email@ym3il.com', password: '12345', password_confirmation: '12345')
      visit new_movie_party_path('730154')
      within '.new-party-form' do
        fill_in 'Duration', with: 145
        select '2022', from: '_date_1i'
        select 'February', from: '_date_2i'
        select '6', from: '_date_3i'
        select '7 PM', from: '_time_4i'
        select '45', from: '_time_5i'
        check("invites_#{user_2.id}")

        check("invites_#{user_3.id}")
        click_button 'Create Party'
        expect(current_path).to eq(dashboard_path)
      end
      visit user_path(user_2)
      within '.parties' do
        expect(page).to have_content("cob's Upcoming Parties:")
      end
    end
  end
end
