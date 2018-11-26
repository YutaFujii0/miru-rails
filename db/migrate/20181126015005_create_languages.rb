class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :code
      t.string :name
      t.string :meal_is

      t.timestamps
    end
  end
end
