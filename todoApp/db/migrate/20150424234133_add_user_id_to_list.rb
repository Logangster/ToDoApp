class AddUserIdToList < ActiveRecord::Migration
  def change
    add_reference :lists, :user_id, index: true, foreign_key: true
  end
end
