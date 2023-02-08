require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.build(:user) }
  let!(:article) { build(:article, user_id: user.id) }

  describe 'attribute: name' do

    context 'when present' do
      it 'is valid' do
        user.name = 'hellooo'
        expect(user).to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        user.name = ''
        expect(user).to be_invalid
      end
    end

    context 'when blank' do
      it 'is invalid' do
        user.name = ' '
        expect(user).to be_invalid
      end
    end

    context 'when nil' do
      it 'is invalid' do
        user.name = nil
        expect(user).to be_invalid
      end
    end

    context 'when length is 32 characters or less' do
      it 'is valid' do
        user.name = 'a' * 32
        expect(user).to be_valid
      end
    end

    context 'when length is more than 32 characters' do
      it 'is invalid' do
        user.name = 'a' * 33
        expect(user).to be_invalid;
      end
    end
  end

  describe 'attribute: email' do

    context 'when present' do
      it 'is invalid' do
        user.email = 'foo@example.com'
        expect(user).to be_valid
      end
    end

    context 'when empty' do
      it 'is invalid' do
        user.email = ''
        expect(user).to be_invalid
      end
    end

    context 'when blank' do
      it 'is invalid' do
        user.email = ' '
        expect(user).to be_invalid
      end
    end

    context 'when nil' do
      it 'is invalid' do
        user.email = nil
        expect(user).to be_invalid
      end
    end

    context 'when formats are correct' do
      it 'is valid' do
        user.email = 'user@example.com'
        expect(user).to be_valid

        user.email = 'USER@foo.COM'
        expect(user).to be_valid

        user.email = 'A_US-ER@foo.bar.org'
        expect(user).to be_valid

        user.email = 'foo.bar@baz.jp'
        expect(user).to be_valid

        user.email = 'foo+bar@baz.cn'
        expect(user).to be_valid
      end
    end

    context 'when formats are incorrect' do
      it 'is invalid' do
        user.email = 'user@example,com'
        expect(user).to be_invalid

        user.email = 'user_at_foo.org'
        expect(user).to be_invalid

        user.email = 'user.name@example.'
        expect(user).to be_invalid

        user.email = 'foo@bar_baz.com'
        expect(user).to be_invalid

        user.email = 'foo@bar+baz.com'
        expect(user).to be_invalid
      end
    end

    context 'when already taken' do
      it 'is invalid' do
        FactoryBot.create(:user, email: 'foo@example.com')
        user.email = 'foo@example.com'
        expect(user).to be_invalid
      end
    end

    context 'when case insensitive and not unipue' do
      it 'is invalid' do
        FactoryBot.create(:user, email: 'foo@example.com')
        user.email = 'FOO@EXAMPLE.COM'
        expect(user).to be_invalid
      end
    end
  end

  describe 'attribute: relationship' do
    context 'relationship with article model should be N:1' do
      it 'is true' do
        expect(User.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
  end

end