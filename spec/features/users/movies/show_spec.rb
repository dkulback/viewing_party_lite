require 'rails_helper'

RSpec.describe 'Users movie show page' do
  let(:user) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
  it 'has buttons to create viewing party and to return to discovery page' do
    VCR.use_cassette('your_eyes_tell_show') do
      visit '/movies/730154'
      within '.buttons' do
        expect(page).to have_button('Create Viewing Party')
        expect(page).to have_button('Discover Page')
        click_button('Discover Page')
        expect(current_path).to eq('/discover')
      end
    end
  end
  it 'click create viewing party takes me to create page' do
    VCR.use_cassette('your_eyes_tell_show viewing party') do
      visit '/movies/730154'
      within '.buttons' do
        click_button('Create Viewing Party')
        expect(current_path).to eq(new_movie_party_path('730154'))
      end
    end
  end

  it 'has movie title, average, runtime, genre(s), summary' do
    VCR.use_cassette('your_eyes_tell_show') do
      visit '/movies/730154'
      within '.movie-info' do
        expect(page).to have_content('Title: Your Eyes Tell')
        expect(page).to have_content('Vote Average: 8.8')
        expect(page).to have_content('Runtime: 2 hours 3 minutes')
        expect(page).to have_content('Genre(s): Romance Drama')
        expect(page).to have_content('Summary: A tragic accident')
      end
    end
  end
  it 'review count & author info' do
    VCR.use_cassette('cloud_atlas_reviews_show') do
      visit '/movies/83542'
      within '.movie-info' do
        expect(page).to have_content('Total Reviews: 3')
        expect(page).to have_content('Author: tanty')
        expect(page).to have_content('Review: Interesting film with')
      end
    end
  end

  it 'lists the first ten cast members' do
    VCR.use_cassette('cloud_atlas_cast_show') do
      visit '/movies/83542'
      within '.movie-info' do
        expect(page).to have_content('Tom Hanks as Dr. Henry Goose')
      end
    end
  end
  describe 'when not logged in' do
    it 'redirects to landing page', :vcr do
      visit '/movies/83542' do
        within '.alert' do
          expect(page).to have_content('You must be logged in to view movies')

          expect(current_path).to eq(root_path)
        end
      end
    end
  end
end
