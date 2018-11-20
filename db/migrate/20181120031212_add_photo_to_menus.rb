class AddPhotoToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :photo, :string
  end
end
