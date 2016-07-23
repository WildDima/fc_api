require_dependency "fc_api/application_controller"

module FcApi
  class Api::V1::CardsController < ApplicationController
    before_action :authenticate_user_from_token!
    before_action :set_card, only: [:show, :destroy, :update]


    def index
      @cards = current_user.cards.order('review_date')
    end

    def show
    end

    def create
      @card = Card.new(card_params)
      @card.save
      respond_with @card
    end

    def update
      @card.update_attributes(card_params)
      respond_with @card
    end

    def destroy
      @card.destroy
      respond_with @card
    end


    private

    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date,
                                   :image, :remote_image_url, :image_cache, :remove_image, :block_id)
    end

    def authenticate_user_from_token!
      user_token = params[:user_token].presence
      user       = user_token && User.find_by_authentication_token(user_token.to_s)

      if user
        auto_login user
      end
    end

    def set_card
      @card = current_user.cards.find(params[:id])
    end
  end
end
