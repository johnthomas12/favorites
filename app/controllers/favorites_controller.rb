class FavoritesController < ApplicationController
  require 'open-uri'

  def index
    @favorites = Favorite.all
    @comment = Comment.new
  end


  def timeline
    @favorites = Favorite.all
    @comment = Comment.new
  end

  def show
    @favorite = Favorite.find(params[:id])
    @comment = Comment.new
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new

    @my_secret = ENV["api_key"]

    @url = "https://www.googleapis.com/youtube/v3/videos?id=#{youtube_id(params[:url])}&key=#{@my_secret}&part=snippet,contentDetails,statistics,status"

    @favorite.name = JSON.parse(open(@url).read)["items"][0]["snippet"]["title"]

    @favorite.description = JSON.parse(open(@url).read)["items"][0]["statistics"]["viewCount"].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

    @favorite.url = params[:url]

    @favorite.category_id = params[:category_id]

    @favorite.user_id = params[:user_id]

    if @favorite.save

    @rating = Rating.new

    @rating.number = params[:number]

    @rating.user_id = params[:user_id]

    @rating.favorite_id = @favorite.id

    if @rating.save
      redirect_to cookies[:last_viewed], :notice => "Favorite created successfully."
    else
      redirect_to "/favorites/#{@favorite.id}/edit", :notice => "Favorite created successfully, need to enter valid rating between 0 and 10."
    end

  else
    render 'new'
  end

  end

  def edit
    @favorite = Favorite.find(params[:id])
  end

  def edit1
    @favorite = Favorite.find(params[:id])
  end

  def update
    @favorite = Favorite.find(params[:id])

    my_secret = ENV["api_key"]

    @url = "https://www.googleapis.com/youtube/v3/videos?id=#{youtube_id(params[:url])}&key=#{my_secret}&part=snippet,contentDetails,statistics,status"

    @favorite.name = JSON.parse(open(@url).read)["items"][0]["snippet"]["title"]

    @favorite.description = JSON.parse(open(@url).read)["items"][0]["statistics"]["viewCount"].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

    @favorite.url = params[:url]

    @favorite.category_id = params[:category_id]

      if Rating.find_by_user_id_and_favorite_id(current_user.id,params[:id]).present?
      @rating = Rating.find_by_user_id_and_favorite_id(current_user.id,params[:id])
      @rating.number = params[:number]

      else
      @rating = Rating.new
      @rating.number = params[:number]
      @rating.user_id = params[:user_id]
      @rating.favorite_id = params[:id]

      end

      @favorite.save


    if @rating.save
      redirect_to cookies[:last_viewed], :notice => "Favorite updated successfully."
    else
      render 'edit', :notice => "Please enter valid rating between 0 and 10."
    end

  end

  def destroy
    @favorite = Favorite.find(params[:id])

    @favorite.destroy


    redirect_to "/favorites", :notice => "Favorite deleted."

  end

  private

def sort_column
    Favorite.column_names.include?(params[:sort]) ? params[:sort] : "Name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
