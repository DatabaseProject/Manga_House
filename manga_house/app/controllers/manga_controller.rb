class MangaController < ApplicationController
def index

	@page = params[:page] || 0
	@page = 0 if @page.to_i == -1
	num_item = 2

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
			 order by manga.name asc
			 limit " + (@page.to_i*num_item).to_s + ', ' + ((@page.to_i+1)*num_item).to_s


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
				 @data << {title: title,artist: artist,author: author,manga_id: manga_id,author_id: author_id, artist_id: artist_id,page: page}
			 end

end


def show
	manga_id_ = params[:id]

	sql = "select distinct manga.name as Title,
					author.author_id as AuthorID,
					artist.artist_id as ArtistID,
				  concat(people_artist.first_name,' ',people_artist.last_name) as Artist,
				  concat(people_author.first_name,' ',people_author.last_name) as Author,
				  manga.description as MangaDescription,
				  manga.completeness as MangaCompleteness
			  from manga,
				  artist,
				  author,
				  people as people_author,
				  people as people_artist,
				  chapter
			  where  manga.artist_id = artist.artist_id and 
				  artist.people_id = people_artist.people_id and
				  manga.author_id = author.author_id and 
				  author.people_id = people_author.people_id and 
				  manga.manga_id = " + manga_id_ + ' ' +
				  "order by released_date; "


				  results = ActiveRecord::Base.connection.select_all(sql)	
				  results.each do |result|
					  tmp = result.symbolize_keys
					  title = tmp[:Title]
					  artist = tmp[:Artist]
					  author = tmp[:Author]
					  manga_id = tmp[:MangaID]
					  author_id = tmp[:AuthorID]
					  artist_id = tmp[:ArtistID]
					  completeness = tmp[:MangaCompleteness] == 0 ? 'False' : 'True'
					  description = tmp[:MangaDescription]
					  @data = {title: title,artist: artist,author: author,author_id: author_id, artist_id: artist_id, completeness: completeness, description: description}
				  end

				  sql = "select genre.name as name
				   from manga,
						manga_has_genre,
						genre
				   where manga.manga_id = manga_has_genre.manga_id and
						manga_has_genre.genre_id = genre.genre_id and
						manga.manga_id = " + manga_id_


						@genre = []
						results = ActiveRecord::Base.connection.select_all(sql)	
						results.each do |result|
							tmp = result.symbolize_keys
							@genre << tmp[:name]
						end


						sql = "select manga.name as Name,
						   released_date as Date,
						   chapter.number as Number
			  from manga,chapter 
			  where chapter.manga_id = manga.manga_id and
					manga.manga_id = "  + manga_id_ + ' ' +
					"order by released_date 
			  limit 5"

			  results = ActiveRecord::Base.connection.select_all(sql)	


			  @released_chapter = []
			  results.each do |result|
				  tmp = result.symbolize_keys
				  manga_name = tmp[:Name]
				  date = tmp[:Date]
				  chapter = tmp[:Number]
				  @released_chapter << {manga_name: manga_name,date: date,chapter: chapter}
			  end
end

def page
end

end
