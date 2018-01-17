class StatusController < ApplicationController
  def index
    render plain: "Oh hi #{params[:user_name]}"
  end
end
