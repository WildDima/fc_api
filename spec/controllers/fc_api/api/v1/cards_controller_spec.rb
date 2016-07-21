require 'rails_helper'

module FcApi
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { FcApi::Engine.routes }
    # let(:card) { FactoryGirl.create(:card, user: user) }
    let :user do
      user = object_double('User')
      allow(user).to receive(:authentication_token).and_throw(SecureRandom.urlsafe_base64(nil, false))
    end

    before { allow_any_instance_of(Api::V1::CardsController).to receive(:current_user).and_return(user) }

    describe 'GET #index' do
      it 'returns http success' do
        get :index

        expect(response).to respond_to(:json)
      end
    end
  end
end
