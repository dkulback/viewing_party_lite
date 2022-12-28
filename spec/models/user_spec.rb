require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships / validations' do
    it { should have_many(:user_parties) }
    it { should have_many(:friends) }
    it { should have_many(:parties).through(:user_parties) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
  describe 'creating a user' do
    it 'wont allow a user to be created without valid password' do
      user = User.create(name: 'bill cob', email: 'cob@gmail.com', password: '12345',
                         password_confirmation: '123455667')

      expect(user).to_not have_attribute(:password)
      expect(user.save).to eq(false)

      user = User.create(name: 'bill cob', email: 'cob@gmail.com', password: '12345',
                         password_confirmation: '12345')
      expect(user.save).to eq(true)
    end
  end
  describe '#invites' do
    it 'lists parties this person has been invited to!' do
      user = User.create!(name: 'Bill', email: 'Willy@hotmail.com', password: '12345', password_confirmation: '12345')
      user_2 = User.create!(name: 'Bill', email: 'Willy34@hotmail.com', password: '12345',
                            password_confirmation: '12345')
      party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user_2.id, movie_id: 730_154)
      user.user_parties.create!(party_id: party_1.id, user_id: user.id)
      user.user_parties.create!(party_id: party_2.id, user_id: user.id)
      actual = user.invites
      expected = [party_2]
    end
  end
  describe '#hosting' do
    it 'lists parties this person has been invited to!' do
      user = User.create!(name: 'Bill', email: 'Willy@hotmail.com', password: '12345', password_confirmation: '12345')
      user_2 = User.create!(name: 'Bill', email: 'Willy98@hotmail.com', password: '12345',
                            password_confirmation: '12345')
      party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      party_2 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user_2.id, movie_id: 730_154)
      party_3 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Your Eyes Tell',
                              host: user.id, movie_id: 730_154)
      user.user_parties.create!(party_id: party_1.id, user_id: user.id)
      user.user_parties.create!(party_id: party_2.id, user_id: user.id)
      user.parties << party_3
      actual = user.invites
      expected = [party_1, party_3]
    end
  end
  describe '#user_list' do
    it 'lists all users excpet for yourself and ones youve added' do
      user = User.create!(name: 'Bill', email: 'Willy@hotmail.com', password: '12345', password_confirmation: '12345')
      user2 = User.create!(name: 'John', email: 'John@hotmail.com', password: '12345', password_confirmation: '12345')
      user3 = User.create!(name: 'Chris', email: 'Chris@hotmail.com', password: '12345', password_confirmation: '12345')
      user4 = User.create!(name: 'Chris', email: 'Christr@hotmail.com', password: '12345',
                           password_confirmation: '12345')
      user.friends.create!(friend_id: user4.id)
      actual = user.user_list
      expected = [user2, user3]

      expect(actual).to eq(expected)
    end
  end
end
