# motolife
https://motolife.blog
## サービス概要
バイクにフォーカスを当てたブログサービスです。  
ブログや整備記録などを共有することができます。
## 主な機能
* 記事CRUD
* 画像アップロード
* リッチテキストエディタ
* ユーザー登録/ログイン
* コメント
* ソート
* ページネーション
* 非同期通信(Ajax)
## 使用技術
* Ruby 3.0.2
* Ruby on Rails 7.0.4
* Javascript
* JQuery
* Rspec (model/request/system)
* Celenium
* PostgreSQL/MySQL
* CI/CD: GithubActions
* Deploy: AWS
## ER図
## インフラ構成図
![57dd07f9a2a5e9416aff4ac6f4f1f16e](https://user-images.githubusercontent.com/120924735/221784810-8a7d9dbc-87ae-4ec0-9d1d-ed6472526e67.png)
## 工夫した点
* 記事内容のクオリティを上げるためリッチテキストエディタを実装
* モーダルとAjaxを用いてページ遷移せずにプロフィール編集を可能に

