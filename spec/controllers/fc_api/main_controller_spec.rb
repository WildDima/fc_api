require 'rails_helper'

module FcApi
  RSpec.describe MainController, type: :controller do

    describe "GET #index" do
      it "returns http success" do
        get :index, use_route: :fc_api 
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      context 'with http_auth token' do
        it "returns http success" do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('name','pswrd')
          get :edit, use_route: :fc_api
          expect(response).to have_http_status(:success)
        end

        it "returns http 401" do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('nme','pswrd')
          get :edit, use_route: :fc_api
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'without http_auth token' do
        it "returns http 401" do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('nme','pswrd')
          get :edit, use_route: :fc_api
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

  end
end
