class AddColumnToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :lang, :string
  end
end
