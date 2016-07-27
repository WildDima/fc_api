require 'rails_helper'
require 'faker'

module FcApi
  RSpec.describe Api::V1::TrainerController, type: :controller do
    routes { FcApi::Engine.routes }

    let(:user) { double('User') }
    let(:card) { double('Card') }
    let(:card_valid_params) { { card: {original_text: Faker::Hipster.words, translated_text: Faker::Hipster.words} } }
    let(:check_result_true) { {state: true, distance: 0} }
    let(:trainer_params) { {user_translation: 'test'} }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:t).with(:correct_translation_notice) { 'correct' }
      allow(controller).to receive(:t).with(:incorrect_translation_alert) { 'incorrect' }
      allow(controller).to receive(:t).with('translation_from_misprint_alert') { 'incorrect!' }
      allow(controller).to receive(:trainer_params).and_return(trainer_params)
    end

    before do
      allow(user).to receive_message_chain('cards.order') { [card] }
      allow(user).to receive_message_chain('cards.find') { card }
    end

    before do
      allow(card).to receive(:check_translation) { check_result_true }
    end

    describe 'PATCH #review_card' do
      subject! { patch :review_card, format: :json }

      it { should have_http_status :success }

      it 'should return cards' do
        expect(assigns(:message)).to eq 'correct'
      end
    end
  end
end
