module FcApi
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
    include ActionController::RespondWith
    respond_to :json
    before_action :authenticate_user_from_token!

    private

    def authenticate_user_from_token!
      user_token = params[:user_token].presence
      user       = user_token && User.find_by_authentication_token(user_token.to_s)

      if user
        auto_login user
      else
        respond_with :forbidden
      end
    end

  end
end
