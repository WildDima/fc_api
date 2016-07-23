require 'rails_helper'

module FcApi
  RSpec.describe Api::V1::CardsController, type: :controller do
    routes { FcApi::Engine.routes }
    
    let :user do
      double('User')
    end

    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller.current_user).to receive(:cards).and_return()
      allow(controller.current_user.cards).to receive(:order).and_return(FactoryGirl.create(:card))
    end

    before { allow_any_instance_of(Api::V1::CardsController).to receive(:current_user).and_return(user) }

    describe 'GET #index' do
      it 'returns http success' do
        get :index

        expect(controller.current_user).to eq(user)
      end
    end
  end
end
