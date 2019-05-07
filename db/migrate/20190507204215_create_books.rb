class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :publication_year
      t.integer :pages
      t.string :cover_image

      t.timestamps
    end
  end
end
