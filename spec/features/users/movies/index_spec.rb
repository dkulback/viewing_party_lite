require 'rails_helper'

RSpec.describe 'Users movies page' do
  let(:user) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
  it 'has top rated movies, movies are links to movie details page' do
    VCR.use_cassette('top_rated_movies_index') do
      visit '/discover'
      within '.discover-movies' do
        click_link 'Discover!!'

        expect(current_path).to eq(movies_path)
      end
    end
    VCR.use_cassette('your_eyes_tell_index') do
      within '.top-rated-movies' do
        expect(page.status_code).to eq(200)

        expect(page).to have_content('Your Eyes Tell')
        expect(page).to have_content('Vote Average: 8.7')
        expect(page).to have_content('Dilwale Dulhania Le Jayenge')
        expect(page).to have_link('Your Eyes Tell')
        click_link('Your Eyes Tell')
        expect(current_path).to eq('/movies/730154')
      end
    end
  end

  it 'has a form to search for movies' do
    VCR.use_cassette('search_movies') do
      visit '/discover'
      within '.discover-movies' do
        fill_in 'search', with: 'Shaw'

        click_on 'Search'

        expect(current_path).to eq(movies_path)
      end

      within '.search-movie' do
        expect(page.status_code).to eq(200)
        expect(page).to have_content('Fast & Furious Presents: Hobbs & Shaw')
      end
    end
  end
end
