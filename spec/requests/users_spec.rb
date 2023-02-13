require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:test_user) { FactoryBot.create(:test_user) }
  let!(:article) { create(:article, user_id: user.id) }

  describe "GET #show" do
    it 'returns http successfully' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET #edit" do
    context 'when user logged in' do
      it 'returns http successfully' do
        sign_in user
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user not logged' do
      it "returns 302 response" do
        get edit_user_path(user)
        expect(response).to have_http_status "302"
      end
    end
  end

  describe "PUT #update" do
    it 'returns http successfully' do
      put user_path(user), params: { user: FactoryBot.attributes_for(:test_user) }
      expect(response.status).to eq 302
    end

    it 'redirect successfully' do
      sign_in user
      put user_path(user), params: { user: FactoryBot.attributes_for(:user) }
      expect(response).to redirect_to user_path(user)
    end
  end
end
