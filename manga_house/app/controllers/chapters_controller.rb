class ChaptersController < ApplicationController
	def new

		sql = "select distinct name
			  from manga
			 order by name asc"

			 results = ActiveRecord::Base.connection.select_all(sql)	

			 @mangas = []
			 results.each do |result|
				 tmp = result.symbolize_keys
				 name = tmp[:name]
				 @mangas << {name: name}
			 end
		
		sql = "select distinct concat(first_name,' ',last_name) as ArtistName
			  from artist,
				   people
			  where artist.people_id = people.people_id 
			 order by people.first_name asc"


			 results = ActiveRecord::Base.connection.select_all(sql)	

			 @artists = []
			 results.each do |result|
				 tmp = result.symbolize_keys
				 name = tmp[:ArtistName]
				 @artists << {name: name}
			 end

		sql = "select distinct concat(first_name,' ',last_name) as AuthorName
			  from author,
				   people
			  where author.people_id = people.people_id 
			 order by people.first_name asc"


			 results = ActiveRecord::Base.connection.select_all(sql)	

			 @authors = []
			 results.each do |result|
				 tmp = result.symbolize_keys
				 name = tmp[:AuthorName]
				 @authors << {name: name}
			 end
	
		sql = "select name as PublisherName
			  from publisher
			 order by name asc"

			 results = ActiveRecord::Base.connection.select_all(sql)	

			 @publishers = []
			 results.each do |result|
				 tmp = result.symbolize_keys
				 name = tmp[:PublisherName]
				 @publishers << {name: name}
			 end
	
		sql = "select distinct name as GenreName
			   from genre
			   order by name asc"

			 results = ActiveRecord::Base.connection.select_all(sql)	

			 @genres = []
			 i = 1
			 results.each do |result|
				 tmp = result.symbolize_keys
				 name = tmp[:GenreName]
				 num = i
				 i+=1
				 @genres << {name: name,num: num}
			 end
	end

	def create
	  manga_name = params[:select_manga]
	  @manga = Manga.find_by(name: manga_name)
	  @chapter = Chapter.new
	  @chapter.manga_id =  @manga.manga_id
	  @chapter.number =  params[:input_number]
	  @chapter.name =  params[:input_name]
	  @chapter.volumn =  params[:input_volumn]
	  @chapter.volumn =  params[:input_volumn]
	  currentTime = Time.now.to_s
	  index = currentTime =~/[-\+]/
	  @chapter.released_date = currentTime
	  @chapter.save

	  redirect_to admins_path
	end
end
