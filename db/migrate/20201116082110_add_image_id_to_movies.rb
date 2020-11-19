class AddImageIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :image_id, :string
  end
end
