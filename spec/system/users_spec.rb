require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:test_user) { FactoryBot.create(:test_user) }

  describe 'before signup' do
    before do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
    end

    context 'when able to signup' do 
      it 'is created' do
        fill_in "user_name", with: Faker::Lorem.characters(number: 10)
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content('ログアウト')
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end

    context 'when email is empty' do
      it 'is unable' do
        fill_in "user_name", with: Faker::Lorem.characters(number: 10)
        fill_in 'user_email', with: ""
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        expect(page).to have_content "メールアドレスを入力してください"
      end
    end

    context 'when email is already taken' do
      it 'is unable' do
        fill_in "user_name", with: Faker::Lorem.characters(number: 10)
        fill_in 'user_email', with: "testuser@example.com"
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        expect(page).to have_content "メールアドレスはすでに使用されています"
      end
    end

    context 'when name is empty' do
      it 'is unable' do
        fill_in "user_name", with: ""
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_password', with: "password"
        fill_in 'user_password_confirmation', with: "password"
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        expect(page).to have_content "名前を入力してください"
      end
    end

    context 'when password is empty' do
      it 'is unable' do
        fill_in "user_name", with: Faker::Lorem.characters(number: 10)
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_password', with: ""
        fill_in 'user_password_confirmation', with: ""
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        expect(page).to have_content "パスワードを入力してください"
      end
    end
  end

  describe "after login" do
    before do
      sign_in user
    end

    context 'when editing self introduction' do
      it 'is successfully updated' do
        visit edit_user_path(user)
        fill_in "user_self_introduction", with: "Good morning"
        find('input[name="commit"]').click
        expect(user.reload.self_introduction).to eq "Good morning"
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content "プロフィールを更新しました"
      end
    end

    context 'when editing profile image' do
      it 'is successfully updated' do
        visit edit_user_path(user)
        @user_old_profile_image = nil
        attach_file 'user[profile_image]', File.join(Rails.root, 'spec/fixtures/images/test.jpg')
        find('input[name="commit"]').click
        expect(user.reload.profile_image).not_to eq @user_old_profile_image
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content "プロフィールを更新しました"
      end
    end
    
    context 'when accessed other user edit page' do
      it 'is unable to access' do
        other_user = FactoryBot.create(:user)
        visit edit_user_path(other_user)
        expect(page).to have_content '他人のアカウントを編集することは出来ません'
        expect(current_path).to eq root_path
      end
    end
  end
end
