require 'rails_helper'
RSpec.describe Friend, type: :model do
  describe 'validations' do
    it { should belong_to(:user) }
  end
end