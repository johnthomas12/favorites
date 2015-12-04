class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new

    @rating.number = params[:number]

    @rating.user_id = params[:user_id]

    @rating.favorite_id = params[:favorite_id]



    if @rating.save
      redirect_to "/ratings", :notice => "Rating created successfully."
    else
      render 'new'
    end

  end

  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])


    @rating.number = params[:number]

    @rating.user_id = params[:user_id]

    @rating.favorite_id = params[:favorite_id]



    if @rating.save
      redirect_to "/ratings", :notice => "Rating updated successfully."
    else
      render 'edit'
    end

  end

  def destroy
    @rating = Rating.find(params[:id])

    @rating.destroy


    redirect_to "/ratings", :notice => "Rating deleted."

  end
end
