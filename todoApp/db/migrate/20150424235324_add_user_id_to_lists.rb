class AddUserIdToLists < ActiveRecord::Migration
  def change
    add_column :lists, :user_id, :reference
  end
end
