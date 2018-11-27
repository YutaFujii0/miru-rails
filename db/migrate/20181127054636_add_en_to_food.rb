class AddEnToFood < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :en, :string
  end
end
