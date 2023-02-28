// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"


// 画像クリックでフォルダを表示させる
$(document).on('click', "#cover-image", function() {
  $("#article_image").click();
  return false;
});

$(document).on('click', "#cover-image", function() {
  $("#user_profile_image").click();
  return false;
});


$(function(){
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $(document).on('change', '#article_image', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".article-image");
        //t = this;

    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.attr("src",e.target.result)
      };
    })(file);

    reader.readAsDataURL(file);
  });
});

$(function(){
  $(document).on('change', '#user_profile_image', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".change-profile-image");

    if(file.type.indexOf("image") < 0){
      return false;
    }

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.attr("src",e.target.result)
      };
    })(file);

    reader.readAsDataURL(file);
  });
});