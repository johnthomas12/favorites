class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    @comment = Comment.new
  end

  def index1
    @favorites = Favorite.all
    @comment = Comment.new
  end

  def show
    @favorite = Favorite.find(params[:id])
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new

    @favorite.name = params[:name]

    @favorite.description = params[:description]

    @favorite.url = params[:url]

    @favorite.category_id = params[:category_id]

    @favorite.user_id = params[:user_id]

    if @favorite.save

    @rating = Rating.new

    @rating.number = params[:number]

    @rating.user_id = params[:user_id]

    @rating.favorite_id = @favorite.id

    if @rating.save
      redirect_to "/favorites", :notice => "Favorite created successfully."
    else
      render 'new'
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

    @favorite.name = params[:name]

    @favorite.description = params[:description]

    @favorite.url = params[:url]

    @favorite.category_id = params[:category_id]


    if Rating.find_by_user_id_and_favorite_id(current_user.id,params[:id]).present?
    @rating = Rating.find_by_user_id_and_favorite_id(current_user.id,params[:id])
    @rating.number = params[:number]
    @rating.save
    else
    @rating = Rating.new
    @rating.number = params[:number]
    @rating.user_id = params[:user_id]
    @rating.favorite_id = params[:id]
    @rating.save
    end

    if @favorite.save
      redirect_to "/favorites", :notice => "Favorite updated successfully."
    else
      render 'edit'
    end

  end

  def destroy
    @favorite = Favorite.find(params[:id])

    @favorite.destroy


    redirect_to "/favorites", :notice => "Favorite deleted."

  end
end
