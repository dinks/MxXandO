class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_user_from_session

  private

    def set_user_from_session
      @_current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])

      if @_current_user == nil
        @_current_user = User.create
        session[:current_user_id] = @_current_user.id
      end

      @_current_user.is_online!

      $redis.publish 'user.create', User.all_online.to_json

    end

end
