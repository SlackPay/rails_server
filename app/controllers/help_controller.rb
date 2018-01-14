class HelpController < ApplicationController
  def index

    render plain: " `/splack` requires three variables @userName, amount, coin separated by spaces
      `/set_address` sets your receive address
      `/view_address` views the address you have set to recieve
      `/check_balance` checks your current Coinbase balances
      `/hello` says hello"
  end
end
