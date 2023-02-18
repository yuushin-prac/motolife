require 'rails_helper'

RSpec.describe "Articles", js: true, type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  let!(:comment) { FactoryBot.build(:comment, user_id: user.id, article_id: article.id) }

  before do
    sign_in user
  end

  describe 'create article' do
    context 'when comment present' do
      it 'is created' do
        visit article_path(article)
        count = article.comments.count
        fill_in "comment_comment_content" , with: Faker::Lorem.characters(number: 60)
        click_button '送信'
        visit article_path(article)
        expect(article.comments.count).to eq (count + 1)
      end
    end
  end
end