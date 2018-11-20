class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.boolean :deleted

      t.timestamps
    end
  end
end
