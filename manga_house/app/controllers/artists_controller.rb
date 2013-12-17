class ArtistsController < ApplicationController
  def index

	  @page = params[:page] || 0
	  @page = 0 if @page.to_i == -1
	  num_item = 10

	  sql = "select distinct concat(people.first_name,' ',people.last_name) as Artist,
	  			    artist.artist_id as ArtistID
			  from artist, people 
			  where  artist.people_id = people.people_id 
			  order by people.first_name, people.last_name
			  limit " + (@page.to_i*num_item).to_s + ', ' + ((@page.to_i+1)*num_item).to_s
	  results = ActiveRecord::Base.connection.select_all(sql)	

	  @data = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  artist = tmp[:Artist]
		  artist_id = tmp[:ArtistID]
		  @data << {artist: artist,artist_id: artist_id}
	  end
  end

  def show
	  artist_id = params[:id]
	  sql = "select first_name,
					last_name, birthday from people,artist 
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

	  sql_ = "select manga.name as Name,
	  				 manga.manga_id as MangaID,
			         released_date as Date,
				     chapter.number as Number
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
		  chapter = tmp[:Number]
		  manga_id = tmp[:MangaID]
		  @released_chapter << {manga_name: manga_name,manga_id: manga_id,date: date,chapter: chapter}
	  end


  end

  def create
	  #render text: params[:artists].inspect
	  @people = People.find_by(first_name: params[:input_first_name])
	  if @people == nil
		  @people = People.new
		  @people.first_name = params[:input_first_name]
		  @people.last_name = params[:input_last_name]
		  @people.birthday = params[:birthday]
		  @people.image_directory = params[:image_directory]
		  @people.save
	  end
	  @artist = Artist.new
	  @artist.people_id = @people.people_id
	  @artist.save
	  
	  redirect_to admins_path
  end


end
