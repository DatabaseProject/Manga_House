class CreateMangaHasGenres < ActiveRecord::Migration
  def change
    create_table :manga_has_genres do |t|

      t.timestamps
    end
  end
end
