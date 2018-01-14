class UsersController < ApplicationController
  def set_address
    slack_user_id   = params[:user_id]
    slack_user_name = params[:user_name]
    receive_address = params[:receive_address]

    user = User.find_by(slack_user_id: slack_user_id)


    if user
      user.receive_address = receive_address
      user.save
    else
      User.create(receive_address: reveive_address, slack_user_id: slack_user_id, slack_user_name: slack_user_name)
    end

    render plain: "Success. Address set to #{receive_address}!"
  end
end
