class ChangeTextToBeStringInReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :text, :string
  end
end
