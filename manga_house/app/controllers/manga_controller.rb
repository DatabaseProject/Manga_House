class MangaController < ApplicationController
  def index

	  sql = "select distinct manga.name as Title,
	  			  manga.manga_id as MangaID,
	  			  author.author_id as AuthorID,
	  			  artist.artist_id as ArtistID,
				  concat(people_artist.first_name,' ',people_artist.last_name) as Artist,
				  concat(people_author.first_name,' ',people_author.last_name) as Author
			  from manga,
				  artist,
				  author,
				  people as people_author,
				  people as people_artist,
				  chapter
			  where  manga.artist_id = artist.artist_id and 
				  artist.people_id = people_artist.people_id and
				  manga.author_id = author.author_id and 
				  author.people_id = people_author.people_id
			 order by released_date; "
	  results = ActiveRecord::Base.connection.select_all(sql)	

	  @data = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  title = tmp[:Title]
		  artist = tmp[:Artist]
		  author = tmp[:Author]
		  manga_id = tmp[:MangaID]
		  author_id = tmp[:AuthorID]
		  artist_id = tmp[:ArtistID]
		  @data << {title: title,artist: artist,author: author,manga_id: manga_id,author_id: author_id, artist_id: artist_id}
	  end
  end

  def show
  end

  def page

	  render text: 'ok'
	#render text: params[:get].inspect
	#render text: 'ok'
  end
end
