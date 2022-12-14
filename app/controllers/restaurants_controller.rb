class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    if params[:query].present?
      @restaurants = Restaurant.where("name LIKE '%#{params[:query]}%' OR CATEGORY LIKE '%#{params[:query]}%'")
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(article_params)
    if @restaurant.save
      redirect_to restaurants_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
