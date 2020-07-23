class DealersController < ApplicationController
  def index
    dealers = Dealer.all
    render json: dealers
  end

  def show
  end

  #private

  #def dealer
  #  @dealer ||= Dealer.find(params[:id])
  #end
end
