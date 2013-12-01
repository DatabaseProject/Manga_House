class AuthorController < ApplicationController
  def index

	  @page = params[:page] || 0
	  @page = 0 if @page.to_i == -1
	  num_item = 2

	  sql = "select distinct concat(people.first_name,' ',people.last_name) as Author_name, author_id as AuthorID
			  from author, people 
			  where  author.people_id = people.people_id 
	 		  order by people.first_name, people.last_name
			  limit " + (@page.to_i*num_item).to_s + ', ' + ((@page.to_i+1)*num_item).to_s

	  results = ActiveRecord::Base.connection.select_all(sql)	

	  @data = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  author_name = tmp[:Author_name]
		  author_id = tmp[:AuthorID]
		  @data << {author_name: author_name, author_id: author_id}
	  end
  end

  def show
	  author_id = params[:id]
	  sql = "select first_name, last_name, birthday
			  from people,author 
			  where author.people_id = people.people_id and
			  		author.author_id = " + author_id

	  results = ActiveRecord::Base.connection.select_all(sql)	


	  results.each do |result|
		  tmp = result.symbolize_keys
		  first_name = tmp[:first_name]
		  last_name = tmp[:last_name]
		  birthday = tmp[:birthday]
		  @author_info = {first_name: first_name, last_name: last_name, birthday: birthday}
	  end

	  sql_ = "select manga.name as Name,
	  				 manga.manga_id as MangaID,
			         released_date as Date,
				     chapter.number as Number
	  		  from manga,chapter 
	  		  where chapter.manga_id = manga.manga_id and
	 			    manga.author_id = "  + author_id
	  		  "order by released_date 
	          limit 5"

	  results = ActiveRecord::Base.connection.select_all(sql_)	


	  @released_chapter = []
	  results.each do |result|
		  tmp = result.symbolize_keys
		  manga_name = tmp[:Name]
		  manga_id = tmp[:MangaID]
		  date = tmp[:Date]
		  chapter = tmp[:Number]
		  @released_chapter << {manga_name: manga_name,manga_id: manga_id,date: date,chapter: chapter}
	  end


  end
end
