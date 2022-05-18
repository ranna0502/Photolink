# frozen_string_literal: true

require 'rails_helper'


describe '投稿のテスト' do
  let!(:activity_point) { FactoryBot.create(:activity_point) }
  let!(:user) { FactoryBot.create(:user) }
  # allow(controller)
  #   .to receive(:current_user)
  #   .and_return(user)
  # before do
  #   visit new_user_session_path
  #   fill_in 'user[email]', with: user.email
  #   fill_in 'user[password]', with: user.password
  #   click_button 'ログイン'
  # end

  describe 'トップ画面(top_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に新規登録ページへのリンクが表示されているか' do
        expect(page).to have_link"",href:new_user_registration_path
      end
      it 'トップ画面(root_path)にaboutページへのリンクが表示されているか' do
        expect(page).to have_link"",href:about_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe 'about画面(about_path)のテスト' do
    before do
      visit about_path
    end
    context '表示の確認' do
      it 'about画面(about_path)に新規登録ページへのリンクが表示されているか' do
        expect(page).to have_link"",href:new_user_registration_path
      end
    end
  end
  describe '活動地点の登録画面のテスト' do
    before do
      sign_in user
      visit new_activity_point_path
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'activity_point[time]', with: '11:30'
        fill_in 'activity_point[date]', with: '2022/1/1'
        find("#activity_point_person").find("option[value='1']").select_option
        fill_in 'activity_point[spot]', with:  Faker::Lorem.characters(number:10)
        find("#activity_point_prefecture").find("option[value='北海道']").select_option
        fill_in 'activity_point[address]', with:  Faker::Lorem.characters(number:10)
        choose 'activity_point_activity_status_photographer'
        fill_in 'activity_point[request]', with:  Faker::Lorem.characters(number:30)
        click_button '登録する'
        expect(page).to have_current_path user_path(user)
        expect(page).to have_content '活動登録しました'
      end
      it '投稿に失敗する' do
        click_button '登録する'
	      expect(page).to have_content 'エラー'
	      expect(current_path).to eq('/activity_points')
	    end
	    it '投稿後のリダイレクト先は正しいか' do
        fill_in 'activity_point[time]', with: '11:30'
        fill_in 'activity_point[date]', with: '2022/1/1'
        find("#activity_point_person").find("option[value='1']").select_option
        fill_in 'activity_point[spot]', with:  Faker::Lorem.characters(number:10)
        find("#activity_point_prefecture").find("option[value='北海道']").select_option
        fill_in 'activity_point[address]', with:  Faker::Lorem.characters(number:10)
        choose 'activity_point_activity_status_photographer'
        fill_in 'activity_point[request]', with:  Faker::Lorem.characters(number:30)
        click_button '登録する'
        expect(page).to have_current_path user_path(user)
	    end
    end
  end


end
