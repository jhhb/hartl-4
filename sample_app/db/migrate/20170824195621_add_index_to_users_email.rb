class AddIndexToUsersEmail < ActiveRecord::Migration
  def up
  	add_index :users, :email, unique: true
  end
end
