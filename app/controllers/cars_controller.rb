class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @cars = CarDetail.where(:en => params[:id]).select([:id, :name, :model, :price])
  end

  def detail
    @car = CarDetail.find(params[:id])
  end
end
