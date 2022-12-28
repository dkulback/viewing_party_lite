class Friend < ApplicationRecord
  belongs_to :user
  enum status: %i[pending accepted declined]
end
