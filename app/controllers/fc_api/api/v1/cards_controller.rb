require_dependency "fc_api/application_controller"

module FcApi
  class Api::V1::CardsController < ApplicationController
    before_action :set_card, only: [:show, :destroy, :update]


    def index
      @cards = Rails.cache.fetch([params[:controller], params[:action], current_user.id]) do
        current_user.cards.order('review_date')
      end
        respond_with @cards
    end

    def show
      respond_with @card
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

    def set_card
      @card = cache([params[:controller], params[:action], current_user.id]) do
        current_user.cards.find(params[:id])
      end
    rescue => e
      respond_with e.message
    end
  end
end
