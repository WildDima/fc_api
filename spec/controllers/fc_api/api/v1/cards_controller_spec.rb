require 'rails_helper'
require 'faker'

module FcApi
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { FcApi::Engine.routes }

    let(:user) { double('User') }
    let(:card) { double('Card') }
    let(:card_valid_params) { { card: {original_text: Faker::Hipster.words, translated_text: Faker::Hipster.words} } }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive_message_chain('cards.order') { [card] }
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index, format: :json

        expect(response).to have_http_status(:success)
        expect(assigns(:cards)).to eq([card])
        expect(controller.current_user).to eq(user)
      end
    end

    describe 'GET #show' do
      it 'returns http success' do
        allow(user).to receive_message_chain('cards.find') { card }
        get :show, id: 1, format: :json

        expect(response).to have_http_status(:success)
        expect(assigns(:card)).to eq(card)
        expect(controller.current_user).to eq(user)
      end
    end

    describe 'GET #create' do
      it 'returns http success' do
        allow(Card).to receive(:new) { card }
        allow(card).to receive(:save)
        allow(controller).to receive(:respond_with) { card.to_json }
        post :create, card_valid_params.merge(format: :json)

        expect(response).to have_http_status(:success)
        expect(controller.current_user).to eq(user)
      end
    end
  end
end
