module FcApi
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include ActionController::RespondWith
    respond_to :json

  end
end
