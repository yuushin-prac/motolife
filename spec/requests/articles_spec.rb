require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  let(:sample_article) { create(:sample_article, user_id: user.id) }

  describe "GET #index" do
    it 'returns correct http' do
      get articles_path
      expect(response).to have_http_status(:success)
    end

    it 'returns correct http' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it 'returns correct http' do
      get article_path(article)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    context 'when user logged in' do
      it 'returns correct http' do
        sign_in user
        get new_article_path(article)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user not logged' do
      it "returns unauthorized response" do
        get new_article_path(article)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    context 'when all params given' do
      it 'returns correct http' do
        post articles_path, params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to have_http_status "302"
      end

      it 'post successfully' do
        sign_in user
        expect do
          post articles_path, params: { article: FactoryBot.attributes_for(:article) }
        end.to change(Article, :count).by(1)
      end

      it 'redirect successfully' do
        sign_in user
        post articles_path, params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to redirect_to Article.last
      end
    end

    context 'when params are invalid' do
      it 'returns correct http' do
        sign_in user
        post articles_path, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response).to have_http_status "422"
      end

      it 'is not posted' do
        sign_in user
        expect do
          post articles_path, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        end.to_not change(Article, :count)
      end
    end
  end

  describe "PUT #update" do
    let(:update_attributes) do
      {
          title: 'update title',
          content: 'update content'
      }
    end

    context 'when all params given' do
      it 'returns correct http' do
        put article_path(article), params: { article: FactoryBot.attributes_for(:article) }
        expect(response.status).to eq 302
      end

      it 'saves updated article' do
        expect do
          put article_path(article), params: { article: update_attributes }
        end.to change(Article, :count).by(0)
      end

      it 'redirect successfully' do
        sign_in user
        put article_path(sample_article), params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to redirect_to Article.last
      end
    end

    context 'when params are invalid' do
      it 'returns correct http' do
        sign_in user
        put article_path(article), params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response.status).to eq 422
      end

      it 'is not saved' do
        expect do
          put article_path(article), params: { article: FactoryBot.attributes_for(:sample_article, :invalid) }
        end.to_not change(Article.find(sample_article.id), :title)
      end
    end
  end

  describe "GET #edit" do
    context 'when user logged in' do
      it 'returns correct http' do
        sign_in user
        get edit_article_path(article)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user not logged' do
      it "returns correct http" do
        get edit_article_path(article)
        expect(response).to have_http_status "302"
      end
    end
  end

  describe "DELETE #destroy" do
    it "returns correct http" do
      delete article_path(article)
      expect(response.status).to eq 302
    end

    it 'delete article' do
      sign_in user
      expect do
        delete article_path(article)
      end.to change(Article, :count).by(-1)
    end

    it 'redirect to index' do
      sign_in user
      delete article_path(article)
      expect(response).to redirect_to(root_path)
    end
  end
end
