class RemoveTitleFromCmments < ActiveRecord::Migration[5.2]
  def change
    remove_column :cmments, :title, :string
  end
end
