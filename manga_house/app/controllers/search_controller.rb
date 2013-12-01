class SearchController < ApplicationController
  def index

	  @page = params[:page] || 0
	  @page = 0 if @page.to_i == -1
	  num_item = 2

	  @search_keyword = params[:word] || ''

	  @search_type = params[:search_type]

	  @url = request.fullpath.gsub(/(&)page=[0-9].*/,'')
											#.gsub(/search_type=[a-z]*_search/,'')
	  #render text: @url.inspect


	  if params[:search_type] == 'quick_search'
		  if @search_keyword != '' 
			  sql = "select released_date as Date,
						  manga.name as Title,
						  chapter.number as Chapter,
						  concat(people_artist.first_name,' ',people_artist.last_name) as Artist,
						  concat(people_author.first_name,' ',people_author.last_name) as Author,
						  manga.manga_id as MangaID,
						  author.author_id as AuthorID,
						  artist.artist_id as ArtistID
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
						  author.people_id = people_author.people_id and
						  manga.name like '%" + @search_keyword + "%' " +
						  "order by released_date desc
						   limit "  + (@page.to_i*num_item).to_s + ', ' + num_item.to_s

			  results = ActiveRecord::Base.connection.select_all(sql)

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
				@data << {date: date,title: title,artist: artist,author: author,chapter: chapter,manga_id: manga_id,author_id: author_id,artist_id: artist_id}
			  end

		  end
	  else
		  titleCondition = ''
		  authorCondition = ''
		  artistCondition = ''

		  if params[:title_advanced_search_checkbox] != nil && params[:title_advanced_search] != ''
			titleCondition = "and manga.name like '%" + params[:title_advanced_search] + "%' "
		  end

		  if params[:author_advanced_search_checkbox] != nil && params[:author_advanced_search] != ''
			authorCondition = "and concat(people_author.first_name,' ',people_author.last_name) like '%" + params[:author_advanced_search] + "%' "
		  end

		  if params[:artist_advanced_search_checkbox] != nil && params[:artist_advanced_search] != ''
			artistCondition = "and concat(people_artist.first_name,' ',people_artist.last_name) like '%" + params[:artist_advanced_search] + "%' "
		  end


		  actionGenre = params[:action_] != nil ? "genre.name = 'action' or " : ''
		  comedyGenre = params[:comedy] != nil ? "genre.name = 'comedy' or " : ''
		  dramaGenre = params[:drama] != nil ? "genre.name = 'drama' or " : ''
		  fantasyGenre = params[:fantasy] != nil ? "genre.name = 'fantasy' or " : ''
		  magicGenre = params[:magic] != nil ? "genre.name = 'magic' or " : ''
		  mysteryGenre = params[:mystery] != nil ? "genre.name = 'mystery' or " : ''
		  romanceGenre = params[:romance] != nil ? "genre.name = 'romance' or " : ''
		  sportsGenre = params[:sports] != nil ? "genre.name = 'sports' or " : ''

		  genreCondition = actionGenre + comedyGenre + dramaGenre + fantasyGenre + magicGenre + mysteryGenre + romanceGenre + sportsGenre

		  if genreCondition != ''
			  genreCondition += 'false '
			  genreCondition = '(' + genreCondition + ') '
		  else
			  genreCondition = 'true '
		  end

		  sql = "select distinct released_date as Date, manga.name as Title,
					  chapter.number as Chapter,
					  concat(people_artist.first_name,' ',people_artist.last_name) as Artist,
					  concat(people_author.first_name,' ',people_author.last_name) as Author,
					  manga.manga_id as MangaID,
					  author.author_id as AuthorID,
					  artist.artist_id as ArtistID
				 from manga,
					  chapter,
					  artist,
					  author,
					  people as people_author,
					  people as people_artist,
					  genre,
					  manga_has_genre
				 where chapter.manga_id = manga.manga_id and
					  manga.artist_id = artist.artist_id and 
					  artist.people_id = people_artist.people_id and
					  manga.author_id = author.author_id and 
					  author.people_id = people_author.people_id and
					  manga.manga_id = manga_has_genre.manga_id and
		  			  manga_has_genre.genre_id = genre.genre_id "+
					  titleCondition + authorCondition + artistCondition + 
					  'and ' + genreCondition +
				 "order by released_date  desc
				  limit " + (@page.to_i*num_item).to_s + ', ' + num_item.to_s

		  results = ActiveRecord::Base.connection.select_all(sql)

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
			@data << {date: date,title: title,artist: artist,author: author,chapter: chapter,manga_id: manga_id,author_id: author_id,artist_id: artist_id}

		  end
	  end
  end
end
