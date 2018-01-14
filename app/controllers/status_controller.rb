class StatusController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: {status: "Good"} }
    end
  end

end
