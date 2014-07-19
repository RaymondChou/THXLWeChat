class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show

  end
end
