class HelpController < ApplicationController
  def index

    render plain: "/splack requires three variables @userName, amount, coin separated by spaces\\n
      /set_address sets your receive address\\n
      /view_address views the address you have set to recieve\\n
      /check_balance checks your current Coinbase balances\\n
      /hello says hello"
  end
end
