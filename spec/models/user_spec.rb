RSpec.describe User, type: :model do
  before do
    @user = Factorybot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "email can't be blank"
    end