class UsersController < ApplicationController
  def set_address
    slack_user_id   = params[:user_id]
    slack_user_name = params[:user_name]
    receive_address = params[:text]

    user = User.find_by(slack_user_id: slack_user_id)

    if user
      user.receive_address = receive_address
      user.save
    else
      User.create(receive_address: receive_address, slack_user_id: slack_user_id, slack_user_name: slack_user_name)
    end

    render plain: "Success. Address set to #{receive_address}!"
  end

  def view_address
    slack_user_id   = params[:user_id]
    slack_user_name = params[:user_name]

    user = User.find_by(slack_user_id: slack_user_id)

    if user
      render plain: "You're current receive address is #{user.receive_address}"
    else
      render plain: "You haven't set a receive address yet. Use `/set_address xxxxxxxxxxx`."
    end
  end
end
