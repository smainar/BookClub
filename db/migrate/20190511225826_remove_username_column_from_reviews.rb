class RemoveUsernameColumnFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :username, :string
  end
end
