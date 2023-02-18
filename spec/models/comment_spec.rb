require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  let!(:comment) { FactoryBot.build(:comment, user_id: user.id, article_id: article.id) }

  describe 'attribute: comment' do
    context 'when present' do
      it 'is valid' do
      expect(comment).to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        comment.comment_content = ''
        expect(comment).to be_invalid
      end
    end

    context 'when blank' do
      it 'is invalid' do
        comment.comment_content = ' '
        expect(comment).to be_invalid
      end
    end
  end

  context 'when length is more than 140 characters' do
    it 'is invalid' do
      article.title = 'a' * 141
      expect(article).to be_invalid
    end
  end
end