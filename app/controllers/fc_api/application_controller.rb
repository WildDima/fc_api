module FcApi
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
    include ActionController::RespondWith
    respond_to :json
  end
end
