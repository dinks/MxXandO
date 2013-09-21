class V1::UsersController < ApiController
  def online
    return_data = {
      users: User.all_online,
      success: true
    }

    render json: return_data
  end
end
