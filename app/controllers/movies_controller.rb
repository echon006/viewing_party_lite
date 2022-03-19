class MoviesController < ApplicationController

  def index
      @user = User.find(session[:user_id])
      @keyword = params[:keyword]
      @query = CGI.escape "#{@keyword}"
      if @query.present?
        @movie_info = MovieFacade.movies_searched(@query)
      else
        @top_rated_movies = MovieFacade.top_movies
      end
  end

  def show
    @user = User.find(session[:user_id])
    @movie_id = session[:user_id]
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        faraday.params[:api_key] = ENV['movies_api_key']
    end

    movie_id_response = conn.get("/3/movie/#{@movie_id}")
    @movie = JSON.parse(movie_id_response.body, symbolize_names: true)
    cast_response = conn.get("/3/movie/#{@movie_id}/credits")

    @cast = JSON.parse(cast_response.body, symbolize_names: true)
    cast_names = @cast[:cast].map do |person|
      [person[:name], person[:character]]
    end
    @top_10_cast = cast_names[0..10]

    reviews_response = conn.get("/3/movie/#{@movie_id}/reviews")
    @reviews = JSON.parse(reviews_response.body, symbolize_names: true)
    @review_count = @reviews.count
    @reviewers = @reviews[:results].map do |review|
      [review[:author], review[:content]]
    end
  end
end
