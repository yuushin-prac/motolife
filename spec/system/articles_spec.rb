require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  before do
    sign_in user
  end

  describe 'create article' do
    context 'when title and body given' do
      it 'is successfully created' do
        visit new_article_path
        fill_in "article_title", with: Faker::Lorem.characters(number: 10)
        fill_in 'article_body', with: Faker::Lorem.characters(number: 20)
        expect{
          find('input[name="commit"]').click
        }.to change { Article.count }.by(1)
        expect(current_path).to eq article_path(Article.last)
        expect(page).to have_content "記事を投稿しました"
      end
    end

    context 'when attach article image' do
      it 'is successfully attached' do
        visit new_article_path
        @default_article_image = nil
        attach_file 'article[image]', File.join(Rails.root, 'spec/fixtures/images/test.jpg')
        fill_in "article_title", with: Faker::Lorem.characters(number: 10)
        fill_in 'article_body', with: Faker::Lorem.characters(number: 20)
        find('input[name="commit"]').click
        expect(Article.last.reload.image).not_to eq @default_article_image
      end
    end
  end

  describe 'edit article' do
    context 'when title and body arent empty' do
      it "is successfully updated" do
        visit edit_article_path(article)
        fill_in "article_title", with: "hello"
        fill_in 'article_body', with: "qwerty"
        find('input[name="commit"]').click
        expect(article.reload.title).to eq "hello"
        expect(article.reload.body).to eq "qwerty"
        expect(current_path).to eq article_path(article)
      end
    end
  end

  describe 'delete article' do
    context 'when delete article' do
      it 'decreases the number of article' do
        visit edit_article_path(article)
        count = Article.count
        click_on '削除する'
        expect(Article.count).to eq (count - 1)
        expect(current_path).to eq root_path
      end 
    end
  end
end
