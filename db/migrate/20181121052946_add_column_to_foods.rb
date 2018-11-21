class AddColumnToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :images, :string, array: true
  end
end
