require 'rails_helper'

RSpec.describe 'Discover Page' do
  let(:user) do
    User.create(name: 'bill cob', email: 'cob39@gmail.com', password: '12345', password_confirmation: '12345')
  end

  before(:each) do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
  it 'has a button to discover top rated movies' do
    VCR.use_cassette('top_rated_movies') do
      visit '/discover'
      within '.discover-movies' do
        click_link 'Top Rated Movie List'

        expect(current_path).to eq(movies_path)
      end
    end
  end
  it 'has a button to discover top rated movies' do
    user = User.create!(name: 'billy', email: 'email@gmail.com', password: '12345', password_confirmation: '12345')
    VCR.use_cassette('search_movies') do
      visit '/discover'
      within '.form-group' do
        fill_in 'search', with: 'Shaw'

        click_on 'Search'

        expect(current_path).to eq(movies_path)
      end
    end
  end
end
