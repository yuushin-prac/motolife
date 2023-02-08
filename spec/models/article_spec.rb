require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:article) { build(:article, user_id: user.id) }

  describe 'attribute: title' do
    context 'when present' do
      it 'is valid' do
        article.title = 'hellooo'
        expect(article).to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        article.title = ''
        expect(article).to be_invalid
      end
    end

    context 'when blank' do
      it 'is invalid' do
        article.title = ' '
        expect(article).to be_invalid
      end
    end

    context 'when nil' do
      it 'is invalid' do
        article.title = nil
        expect(article).to be_invalid
      end
    end

    context 'when length is 64 characters or less' do
      it 'is valid' do
        article.title = 'a' * 64
        expect(article).to be_valid
      end
    end

    context 'when length is more than 64 characters' do
      it 'is invalid' do
        article.title = 'a' * 65
        expect(article).to be_invalid;
      end
    end
  end

  describe 'attribute: body' do
    context 'when present' do
      it 'is valid' do
        article.body = 'hellooo'
        expect(article).to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        article.body = ''
        expect(article).to be_invalid
      end
    end

    context 'when blank' do
      it 'is invalid' do
        article.body = ' '
        expect(article).to be_invalid
      end
    end

    context 'when nil' do
      it 'is invalid' do
        article.body = nil
        expect(article).to be_invalid
      end
    end
  end

  describe 'attribute: relationship' do
    context 'relationship with user model' do
      it 'should be 1:N' do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

end