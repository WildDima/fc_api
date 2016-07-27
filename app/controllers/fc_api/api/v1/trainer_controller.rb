require_dependency "fc_api/application_controller"

module FcApi
  class Api::V1::TrainerController < ApplicationController
    before_action :authenticate_user_from_token!
    before_action :set_card


    def review_card
      check_result = @card.check_translation(trainer_params[:user_translation])

      if check_result[:state]
        if check_result[:distance] == 0
          @message = t(:correct_translation_notice)
        else
          @message = { message: t('translation_from_misprint_alert'),
                            user_translation: trainer_params[:user_translation],
                            original_text: @card.original_text,
                            translated_text: @card.translated_text }
        end
      else
        @message = t(:incorrect_translation_alert)
      end
      render json: @message.to_json
    end


    private

    def authenticate_user_from_token!
      user_token   = params[:user_token].presence
      current_user = user_token && User.find_by_authentication_token(user_token.to_s)

      if current_user
        auto_login current_user
      end
      p current_user
    end

    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def trainer_params
      params.permit(:user_translation)
    end
  end
end
