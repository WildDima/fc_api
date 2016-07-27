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
      allow(controller).to receive(:respond_with) { controller.render json: card.to_json }
      allow(user).to receive_message_chain('cards.find') { card }
    end

    describe 'GET #index' do
      subject! { get :index, format: :json }

      it { should have_http_status :success }

      it 'should return cards' do
        expect(assigns(:cards)).to eq([card])
      end

      it 'returns correct user' do
        expect(controller.current_user).to eq(user)
      end
    end

    describe 'GET #show' do
      subject! { get :show, id: 1, format: :json }

      it { should have_http_status :success }

      it 'should return card' do
        expect(assigns(:card)).to eq(card)
      end

      it 'returns correct user' do
        allow(user).to receive_message_chain('cards.find') { card }
      end
    end

    describe 'GET #create' do
      before do
        allow(Card).to receive(:new) { card }
        allow(card).to receive(:save)
      end

      subject! { post :create, card_valid_params.merge(format: :json) }

      it { should have_http_status :success }

      it 'should return card' do
        expect(assigns(:card)).to eq(card)
      end
    end

    describe 'PATCH #update' do
      before do
        allow(card).to receive(:update_attributes) { card }
      end

      subject! { patch :update, id: 1, card: card_valid_params.merge(format: :json) }

      it { should have_http_status :success }

      it 'should return card' do
        expect(assigns(:card)).to eq(card)
      end
    end

    describe 'PATCH #destroy' do
      before do
        allow(card).to receive(:destroy) { card }
      end

      subject! { delete :destroy, id: 1 }

      it { should have_http_status :success }

      it 'should return card' do
        expect(assigns(:card)).to eq(card)
      end
    end
  end
end
