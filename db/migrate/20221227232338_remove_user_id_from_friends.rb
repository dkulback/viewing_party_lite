class RemoveUserIdFromFriends < ActiveRecord::Migration[5.2]
  def change
    remove_column :friends, :user_id, :bigint
  end
end
