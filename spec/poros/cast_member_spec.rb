require 'rails_helper'

RSpec.describe Review do
  let(:cast_member) { CastMember.new({ name: 'Tom Hanks', character: 'Train Conductor' }) }
  describe 'initialzie' do
    it 'exists' do
      actual = cast_member
      expected = CastMember
      expect(actual).to be_a(expected)
    end
  end
  describe 'attributes' do
    it 'has a name' do
      actual = cast_member.name
      expected = 'Tom Hanks'

      expect(actual).to eq(expected)
    end

    it 'has a charactr' do
      actual = cast_member.character
      expected = 'Train Conductor'
      expect(actual).to eq(expected)
    end
  end
end
