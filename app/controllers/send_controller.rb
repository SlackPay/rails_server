require 'coinbase/wallet'


class SendController < ApplicationController
  @yasin_client = Coinbase::Wallet::Client.new(api_key: ENV["YASIN_COIN_KEY"], api_secret: ENV["YASIN_COIN_SECRET"])
  @david_client = Coinbase::Wallet::Client.new(api_key: ENV["DAVID_COIN_KEY"], api_secret: ENV["DAVID_COIN_SECRET"])

  # USER = {
  #   # @admin: dylan_client
  #   david: david_client,
  #   email: yasin_client
  # }

  before_filter :authenticate_slack

  api :POST, '/send/'
  def create
    authenticate_slack

    slack_arguments = params[:text].split(" ")
    # to_account = slack_arguments.first
    amount = slack_arguments.last

    send_payment(amount)

    if @error
      format.html { render plain: "Doh, Something Went Wrong: #{@error}" }
    else
      format.html { render plain: "Success, Sent #{amount}!" }
    end
  end

  private
  def authenticate_slack
    raise "Incorrect Team. Unauthorized" unless params[:team_id] == ENV["TEAM_ID"]
  end


  def send_payment(amount)
    # dylan_client = Coinbase::Wallet::Client.new(api_key: ENV["DYLAN_COIN_KEY"], api_secret: ENV["DYLAN_COIN_SECRET"])
    @yasin_client = Coinbase::Wallet::Client.new(api_key: ENV["YASIN_COIN_KEY"], api_secret: ENV["YASIN_COIN_SECRET"])
    @david_client = Coinbase::Wallet::Client.new(api_key: ENV["DAVID_COIN_KEY"], api_secret: ENV["DAVID_COIN_SECRET"])

    david_bch_account = @david_client.accounts.first
    yasin_bch_account = @yasin_client.accounts.first

    begin
      @david_client.send(david_bch_account["id"], { to: yasin_bch_account.addresses.first["address"], amount: amount, currency: "BCH" })
    rescue Exception => e
      @error = e
    end
  end

  def generate_response
    {
       "ok": true,
       "channel": params[:channel_id],
       "ts": Time.now.to_i,
       "message": {
           "text": "Here’s a message for you",
           "username": params[:user_name],
           "bot_id": "????????",
           "attachments": [
               {
                   "text": "This is an attachment",
                   "id": 1,
                   "fallback": "This is an attachment’s fallback"
               }
           ],
           "type": "message",
           "subtype": "bot_message",
           "ts": Time.now.to_i
       }
    }

  end
end



# Parameters: {"token"=>"WI7y8qD2fs4sD4QmVbUYuDlW", "team_id"=>"T8RRT17FC", "team_domain"=>"helios-coop",
#               "channel_id"=>"C8RSSQMCY", "channel_name"=>"oasis", "user_id"=>"U8SNDPAS2", "user_name"=>"connor.bennette",
#               "command"=>"/send", "text"=>".001 bch", "response_url"=>"https://hooks.slack.com/commands/T8RRT17FC/298492048899/jVF4ydCuaSbYsEJ8NXitmkR4",
#               "trigger_id"=>"299651289671.297877041522.a389bd9a7aec0ae3fbbd3dab79cf4888"}
