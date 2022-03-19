require 'rails_helper'
RSpec.describe 'users show page' do
  let(:user_1) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user_1)
  end
  it 'has user name, button to discover movies & section that lists viewing parties' do
    user_2 = User.create!(name: 'billy', email: '3mail@gmail.com', password: '12345', password_confirmation: '12345')
    user_3 = User.create!(name: 'billy', email: '6mail@gmail.com', password: '12345', password_confirmation: '12345')
    party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                            host: user_1.id, movie_id: 730_154)
    party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Cloud Atlas',
                            host: user_2.id, movie_id: 83_542)
    user_1.parties << party_1
    user_1.parties << party_2
    user_2.parties << party_2

    VCR.use_cassette('users-show') do
      visit dashboard_path
      within '.name' do
        expect(page).to have_content(user_1.name)
      end
      within '.links' do
        expect(page).to have_link('Discover Movies')
      end
      within '.parties' do
        expect(page).to have_content(party_1.movie)
        expect(page).to have_content(party_1.movie)
      end
      within '.links' do
        click_link('Discover Movies')
        expect(current_path).to eq(discover_path)
      end
    end
  end
  it 'shows all the movie parties a user has been invited to' do
    user_2 = User.create!(name: 'Jim', email: '6mail@gmail.com', password: '12345', password_confirmation: '12345')
    user_3 = User.create!(name: 'Hogger', email: '5mail@gmail.com', password: '12345', password_confirmation: '12345')

    party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                            host: user_1.id, movie_id: 730_154)
    party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Cloud Atlas',
                            host: user_2.id, movie_id: 83_542)
    user_1.parties << party_2
    user_2.parties << party_2
    user_3.parties << party_2
    VCR.use_cassette('user_invited_movies') do
      visit dashboard_path
      within '.parties' do
        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w300/amNMifaMEd0FBOR289OcnRAJjTI.jpg']")
        expect(page).to have_link('Cloud Atlas')
        expect(page).to have_content("Date: #{party_2.date} Time: #{party_2.start_time}")
        bold = find('.host')
        expect(bold).to have_content('Jim')
        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_3.name)
        expect(page).to have_content(user_2.name)
      end
    end
  end
end
