class ChangeColumnDefaultInResults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :results, :order, from: nil, to: 0
  end
end
