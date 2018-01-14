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
    to_user_name = slack_arguments.first.gsub("@", "")
    amount = slack_arguments[1]

    if amount.to_i > 0.0001000
      send_payment(amount, to_user_name)
    else
      @error = "Max send is 1000 Satoshis, because we've already been hacked."
    end

    if @error
      render plain: "Doh, Something Went Wrong: #{@error}"
    else
      render plain: "Success, Sent #{amount} to #{to_user_name}!"
    end
  end

  private
  def authenticate_slack
    raise "Unauthorized Incorrect Team or Token." unless params[:team_id] == ENV["TEAM_ID"] && params[:token] == ENV["SLACK_TOKEN"]
  end


  def send_payment(amount, to_user_name)
    # dylan_client = Coinbase::Wallet::Client.new(api_key: ENV["DYLAN_COIN_KEY"], api_secret: ENV["DYLAN_COIN_SECRET"])
    @david_client = Coinbase::Wallet::Client.new(api_key: ENV["DAVID_COIN_KEY"], api_secret: ENV["DAVID_COIN_SECRET"])

    david_bch_account = @david_client.accounts.last
    to_user = User.find_by(slack_user_name: to_user_name)

    begin
      @david_client.send(david_bch_account["id"], { to: to_user.receive_address, amount: amount, currency: "BCH" })
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
