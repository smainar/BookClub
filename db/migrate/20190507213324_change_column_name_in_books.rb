class ChangeColumnNameInBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :name, :title
  end
end
