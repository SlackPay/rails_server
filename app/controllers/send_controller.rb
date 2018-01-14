class SendController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_slack

  api :POST, '/send/'
  def create
    @amount = params[:amount]

    respond_to do |format|
      # format.html
      format.json { render json: {amount: @amount} }
    end
  end

  private
  def authenticate_slack
    true # get a api key from request
  end

end
