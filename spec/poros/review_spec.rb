require 'rails_helper'

RSpec.describe Review do
  let(:review) { Review.new({ author_details: { username: 'tanty' }, content: 'worst movie' }) }
  describe 'initialzie' do
    it 'exists' do
      actual = review
      expected = Review
      expect(actual).to be_a(expected)
    end
  end
  describe 'attributes' do
    it 'has a username' do
      actual = review.username
      expected = 'tanty'

      expect(actual).to eq(expected)
    end

    it 'has content' do
      actual = review.content
      expected = 'worst movie'
      expect(actual).to eq(expected)
    end
  end
end
