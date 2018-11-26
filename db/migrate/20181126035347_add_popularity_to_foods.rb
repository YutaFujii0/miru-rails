class AddPopularityToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :popularity, :integer
  end
end
