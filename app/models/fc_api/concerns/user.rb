module FcApi
  module Concerns
    module User
      extend ActiveSupport::Concern

      included do
        before_save :ensure_authentication_token
      end

      def ensure_authentication_token
        if authentication_token.blank?
          self.authentication_token = generate_authentication_token
        end
      end

      private

      def generate_authentication_token
        loop do
          token = SecureRandom.urlsafe_base64(nil, false)
          break token unless User.where(authentication_token: token).first
        end
      end
    end
  end
end
