class DealersController < ApplicationController
  def index
    Salesforce::SyncronizeRecords.run

    # Only loading 10 dealers temporarily
    dealers = Dealer.limit(10)
    render json: dealers
  end
end
