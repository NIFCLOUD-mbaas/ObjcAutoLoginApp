# 【iOS Swift】自動ログイン機能を実装しよう！
![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『会員管理機能』を利用して、ゲームアプリによく見られる「自動ログイン機能」を実装したサンプルプロジェクトです
 * 「自動ログイン機能」とは、ユーザーが会員登録やログイン/ログアウトを意識することなく会員管理を行う機能です。通常の「会員管理機能」を応用して実装することが可能です。
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.12(Sierra)
* Xcode ver. 8.0
* Simulator ver. 10.0
 * iPhone7

※上記内容で動作確認をしています。

## 手順
### 1. [ ニフティクラウドmobile backend ](http://mb.cloud.nifty.com/)の会員登録・ログインとアプリの新規作成
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

### 2. GitHubからサンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをMacにダウンロードします
 * __[SwiftAutoLoginApp](https://github.com/natsumo/SwiftAutoLoginApp/archive/master.zip)__

### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「`SwiftAutoLoginApp.xcodeproj`」をダブルクリックしてXcode開きます

![画像9](/readme-img/009.png)

![画像6](/readme-img/006.png)

* 「SwiftAutoLoginApp.xcodeproj」（青い方）ではないので注意してください！

![画像8](/readme-img/008.png)

### 4. APIキーの設定
* `AppDelegate.swift`を編集します
* 先程[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像7](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
 * 書き換え終わったら`command + s`キーで保存をします

### 6. 動作確認と解説
* Xcode画面の左上、適当なSimulatorを選択します
 * iPhone7の場合は以下のようになります
* 実行ボタン（さんかくの再生マーク）をクリックします

![画像5](/readme-img/005.png)

* アプリが起動します

#### 初回起動時
ユーザー側では特に操作をすることなく、裏では新規会員登録とログインが行われます

##### アプリ側
* 画面は次のようになります

![画像10](/readme-img/010.png)

##### クラウド側
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードを確認してみましょう
* 「会員管理」の中にユーザー登録がされていることが確認できます

![画像11](/readme-img/011.png)

* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の「ユーザー名/パスワード」を使用して会員管理を行う機能を「自動ログイン機能」へ応用しています
 * ここでは、ユーザー名とパスワードとして、「端末ID（UDID）」を取得し起動時に認証を行うことで自動ログインを実現しています。
 * ダッシュボードの「userName」フィールドで登録された端末IDが確認できます。

#### ２回目以降起動時
初回起動時に端末IDで会員情報が登録されているため、２回目以降起動時はログインが行われます

* 左上の「■」ボタンをクリックしてプログラムを停止します
* 再度、実行ボタン（さんかくの再生マーク）をクリックします

##### アプリ側
* 画面は次のようになります

![画像12](/readme-img/012.png)

* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員機能では会員毎に、会員登録やログインを行うたびに更新される「updateDate」というフィールドを持ち、この値を利用して、「最終ログイン」日時の表示をするようにしています
 * 「lastLoginDate」というフィールドに値を移して使用しています

![画像13](/readme-img/013.png)

* 何度か起動し、アプリ側とダッシュボード側を確認してみましょう

## 参考
ここではサンプルアプリに実装済みの内容について紹介します

### SDKのインポートと初期設定
* ニフティクラウドmobile backend のドキュメント（クイックスタート）をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [SwiftでmBaaSを始めよう！(＜CocoaPods＞でuse_framewoks!を有効にした方法)](http://qiita.com/natsumo/items/57d3a4d9be16b0490965)

### ロジック
* `Main.storyboard`でデザインを作成し、`ViewController.swift`にロジックを書いています

#### 自動ログイン処理
```swift
//
//  ViewController.swift
//  SwiftAutoLoginApp
//
//  Created by Natsumo Ikeda on 2016/10/26.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//
import UIKit
import NCMB

class ViewController: UIViewController {
    // label
    @IBOutlet weak var greetingMessage: UILabel!
    @IBOutlet weak var lastVisit: UILabel!
    @IBOutlet weak var dayAndTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // labelの初期化
        greetingMessage.text = ""
        lastVisit.text = ""
        dayAndTime.text = ""

        // UUID取得
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        print("uuid:\(uuid)")

        /* mBaaSログイン */
        NCMBUser.logInWithUsername(inBackground: uuid, password: uuid) { (user, login_error) in
            if login_error != nil {
                // ログイン失敗時の処理
                let login_err : NSError = login_error as! NSError
                print("ログインに失敗しました。エラーコード：\(login_err.code)")

                // 初回利用（会員未登録）の場合
                if login_err.code == 401002 { // 401002：ID/Pass認証エラー
                    /* mBaaS会員登録 */
                    let new_user = NCMBUser()
                    new_user.userName = uuid
                    new_user.password = uuid
                    new_user.signUpInBackground({ (signUp_error) in
                        if signUp_error != nil {
                            // 会員登録失敗時の処理
                            let signUp_err = signUp_error as! NSError
                            print("会員登録に失敗しました。エラーコード：\(signUp_err.code)")
                        } else {
                            // 会員登録成功時の処理
                            print("会員登録に成功しました。")

                            self.greetingMessage.text = "はじめまして！"

                            /* mBaaSデータの保存 */
                            let lastLoginDate = new_user.updateDate
                            new_user.setObject(lastLoginDate, forKey: "lastLoginDate")
                            new_user.saveInBackground({ (save_error) in
                                if save_error != nil {
                                    // 保存失敗時の処理
                                    let save_err = save_error as! NSError
                                    print("最終ログイン日時の保存に失敗しました。エラーコード：\(save_err.code)")

                                } else {
                                    // 保存成功時の処理
                                    print("最終ログイン日時の保存に成功しました。")

                                }
                            })

                        }
                    })
                }

            } else {
                // ログイン成功時の処理
                print("ログインに成功しました")

                self.greetingMessage.text = "おかえりなさい"
                self.lastVisit.text = "最終ログイン"

                // 最終ログイン日時取得

                let lastLoginDate = user?.object(forKey: "lastLoginDate") as! Date
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                let dateStr = formatter.string(from: lastLoginDate)
                self.dayAndTime.text = "\(dateStr)"

                // ログイン日時の上書き
                let updateDate = user?.updateDate
                user?.setObject(updateDate, forKey: "lastLoginDate")
                user?.saveInBackground({ (save_error) in
                    if save_error != nil {
                        // 保存失敗時の処理
                        let save_err = save_error as! NSError
                        print("最終ログイン日時の保存に失敗しました。エラーコード：\(save_err.code)")

                    } else {
                        // 保存成功時の処理
                        print("最終ログイン日時の保存に成功しました。")
                    }
                })
            }
        }
    }
}
```

* 同じ内容の【Objective-C】版もご用意しています
 * https://github.com/NIFTYCloud-mbaas/ObjcAutoLoginApp
