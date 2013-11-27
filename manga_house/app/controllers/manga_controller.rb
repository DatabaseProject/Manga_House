class MangaController < ApplicationController
  def index
	  @people = People.find_by_sql("select * from people where people_id = 1")[0]
	  @artist = Artist.find_by_sql("select * from artist where artist_id = 1")[0]
	  @author = Author.find_by_sql("select * from author where author_id = 1")[0]
	  @genre = Genre.find_by_sql("select * from genre where genre_id = 1")[0]
	  @publisher = Publisher.find_by_sql("select * from publisher where publisher_id = 1")[0]

	  #render template: "artist/index"
   end

  def show
  end
end
