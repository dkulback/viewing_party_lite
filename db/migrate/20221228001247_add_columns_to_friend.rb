class AddColumnsToFriend < ActiveRecord::Migration[5.2]
  def change
    add_column :friends, :friend_id, :bigint
    add_reference :friends, :user, foreign_key: true
  end
end
