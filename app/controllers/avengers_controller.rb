class AvengersController < ApplicationController

  def index
    @avengers = Avenger.order(year: :asc).page(params[:page])
  end

  def show
    @avenger = Avenger.find(params[:id])
  end

  def new
    @avenger = Avenger.new
  end

  private

  def avenger_params
    params.require(:avenger).permit(:name, :alias_list, :gender)
  end

end
