require 'rails_helper'

module FcApi
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { FcApi::Engine.routes }
    let(:user) { FactoryGirl.create(:user) }
    let(:card) { FactoryGirl.create(:card, user: user) }
    let(:rand_user) { FactoryGirl.create(:user) }

    before(:each) {  login_user(user) }

    describe 'GET #index' do
      it 'returns http success' do
        get :index

        expect(response).to respond_to(:json)
      end
    end
  end
end
