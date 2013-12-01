class ReleaseController < ApplicationController
  def index
	  results = ActiveRecord::Base.connection.select_all("select released_date as Date,
															 manga.name as Title,
															 chapter.number as Chapter,
															 concat(people_artist.first_name,' ',people_artist.last_name) as Artist,
															 concat(people_author.first_name,' ',people_author.last_name) as Author,
															 manga.manga_id as MangaID,
															 artist.artist_id as ArtistID,
															 author.author_id as AuthorID
														 from manga,
															 chapter,
															 artist,
															 author,
															 people as people_author,
															 people as people_artist
														 where chapter.manga_id = manga.manga_id and
															 manga.artist_id = artist.artist_id and 
															 artist.people_id = people_artist.people_id and
															 manga.author_id = author.author_id and 
															 author.people_id = people_author.people_id 
														order by released_date desc;")
	  @data = []
	  results.each do |result|
		tmp = result.symbolize_keys
		date = tmp[:Date]
		title = tmp[:Title]
		artist = tmp[:Artist]
		author = tmp[:Author]
		chapter = tmp[:Chapter]
		manga_id = tmp[:MangaID]
		artist_id = tmp[:ArtistID]
		author_id = tmp[:AuthorID]
		@data << {date: date,title: title,artist: artist,author: author,chapter: chapter,manga_id: manga_id,artist_id: artist_id,author_id: author_id}
	  end

  end
end
