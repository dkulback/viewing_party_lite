class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :friends

  validates_presence_of :name, :email, :password, :password_confirmation
  validates_uniqueness_of :email, case_sensitive: false
  has_secure_password

  def invites
    parties.where.not(host: id)
  end

  def hosting
    parties.where(host: id)
  end

  def user_list
    friend_ids = friends.pluck(:friend_id)
    friend_ids << id
    User.all.where.not(id: friend_ids)
  end
end
