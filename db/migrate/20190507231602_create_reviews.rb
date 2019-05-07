class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :username
      t.string :title
      t.integer :rating
      t.integer :text

      t.timestamps
    end
  end
end
