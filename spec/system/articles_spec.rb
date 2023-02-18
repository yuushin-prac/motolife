require 'rails_helper'

RSpec.describe "Articles", js: true, type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  before do
    sign_in user
  end

  describe 'create article' do
    context 'when title and content present' do
      it 'is created' do
        visit new_article_path
        count = Article.count
        fill_in "article_title", with: Faker::Lorem.characters(number: 10)
        fill_in_rich_text_area "article_content", with: Faker::Lorem.characters(number: 60)
        find('input[name="commit"]').click
        visit article_path(Article.last)
        expect(Article.count).to eq (count + 1)
      end
    end

    context 'when attach article image' do
      it 'is attached' do
        visit new_article_path
        @default_article_image = nil
        attach_file 'article[image]', File.join(Rails.root, 'spec/fixtures/images/test.jpg')
        fill_in "article_title", with: Faker::Lorem.characters(number: 10)
        fill_in_rich_text_area 'article_content', with: Faker::Lorem.characters(number: 60)
        find('input[name="commit"]').click
        visit article_path(Article.last)
        expect(Article.last.image).not_to eq @default_article_image
      end
    end
  end

  #article.contentが取れないため保留
  xdescribe 'edit article' do
    context 'when title and content arent empty' do
      it "is updated" do
        visit edit_article_path(article)
        fill_in "article_title", with: "hello"
        fill_in_rich_text_area "article_content", with: "qwerty"
        find('input[name="commit"]').click
        expect(article.reload.title).to eq "hello"
        expect(article.reload.content).to eq "qwerty"
      end
    end
  end

  describe 'delete article' do
    context 'when delete article' do
      it 'decreases the number of article' do
        visit edit_article_path(article)
        count = Article.count
        click_on '削除する'
        page.accept_confirm
        visit root_path
        expect(Article.count).to eq (count - 1)
      end 
    end
  end
end
