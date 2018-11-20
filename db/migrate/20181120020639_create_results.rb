class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :food, foreign_key: true
      t.references :menu, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
