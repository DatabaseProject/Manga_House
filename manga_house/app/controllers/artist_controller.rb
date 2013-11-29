class ArtistController < ApplicationController
  def index
	  sql = "select distinct concat(people.first_name,' ',people.last_name) as Artist
			  from artist, people 
			  where  artist.people_id = people.people_id ; "
	  results = ActiveRecord::Base.connection.select_all(sql)	

	  @data = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  artist = tmp[:Artist]
		  @data << {artist: artist}
	  end
  end

  def show
	  artist_id = params[:id]
	  sql = "select first_name, last_name, birthday
			  from people,artist 
			  where artist.people_id = people.people_id and
			  		artist.artist_id = " + artist_id

	  results = ActiveRecord::Base.connection.select_all(sql)	


	  results.each do |result|
		  tmp = result.symbolize_keys
		  first_name = tmp[:first_name]
		  last_name = tmp[:last_name]
		  birthday = tmp[:birthday]
		  @artist_info = {first_name: first_name, last_name: last_name, birthday: birthday}
	  end

	  sql_ = "select manga.name as Name, released_date as Date
	  		  from manga,chapter 
	  		  where chapter.manga_id = manga.manga_id and
	 			    manga.artist_id = "  + artist_id
	  		  "order by released_date 
	          limit 5"

	  results = ActiveRecord::Base.connection.select_all(sql_)	


	  @released_chapter = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  manga_name = tmp[:Name]
		  date = tmp[:Date]
		  @released_chapter << {manga_name: manga_name,date: date}
	  end


  end
end
