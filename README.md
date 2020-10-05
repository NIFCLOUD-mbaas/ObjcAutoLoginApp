# 【iOS Objective-C】自動ログイン機能を実装しよう！
![画像1](/readme-img/001.png)

## 概要
* [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の『会員管理機能』を利用して、ゲームアプリによく見られる「自動ログイン機能」を実装したサンプルプロジェクトです
 * 「自動ログイン機能」とは、ユーザーが会員登録やログイン/ログアウトを意識することなく会員管理を行う機能です。通常の「会員管理機能」を応用して実装することが可能です。
* 簡単な操作ですぐに [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の機能を体験いただけます★☆

## ニフクラ mobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](https://mbaas.nifcloud.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS Catalina
* Xcode ver. 11.7 
* iPhone11(iOS 13.7)

※上記内容で動作確認をしています。

## 手順
### 1. [ ニフクラ mobile backend ](https://mbaas.nifcloud.com/)の会員登録・ログインとアプリの新規作成
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフクラ mobile backend](https://mbaas.nifcloud.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

### 2. GitHubからサンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをMacにダウンロードします
 * __[ObjcAutoLoginApp](https://github.com/NIFCloud-mbaas/ObjcAutoLoginApp/archive/master.zip)__

### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「`ObjcAutoLoginApp.xcodeproj`」をダブルクリックしてXcode開きます

![画像9](/readme-img/009.png)

![画像6](/readme-img/006.png)

* 「ObjcAutoLoginApp.xcodeproj」（青い方）ではないので注意してください！

![画像8](/readme-img/008.png)

### 4. APIキーの設定
* `AppDelegate.m`を編集します
* 先程[ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボード上で確認したAPIキーを貼り付けます

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

<img src="/readme-img/010.png" alt="画像10" width="320"/>

##### クラウド側
* [ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボードを確認してみましょう
* 「会員管理」の中にユーザー登録がされていることが確認できます

![画像11](/readme-img/011.png)

* [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の「ユーザー名/パスワード」を使用して会員管理を行う機能を「自動ログイン機能」へ応用しています
 * ここでは、ユーザー名とパスワードとして、「端末ID（UDID）」を取得し起動時に認証を行うことで自動ログインを実現しています。
 * ダッシュボードの「userName」フィールドで登録された端末IDが確認できます。

#### ２回目以降起動時
初回起動時に端末IDで会員情報が登録されているため、２回目以降起動時はログインが行われます

* 左上の「■」ボタンをクリックしてプログラムを停止します
* 再度、実行ボタン（さんかくの再生マーク）をクリックします

##### アプリ側
* 画面は次のようになります

<img src="/readme-img/012.png" alt="画像12" width="320"/>

* [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の会員機能では会員毎に、会員登録やログインを行うたびに更新される「updateDate」というフィールドを持ち、この値を利用して、「最終ログイン」日時の表示をするようにしています
 * 「lastLoginDate」というフィールドに値を移して使用しています

![画像13](/readme-img/013.png)

* 何度か起動し、アプリ側とダッシュボード側を確認してみましょう

## 参考
ここではサンプルアプリに実装済みの内容について紹介します

### SDKのインポートと初期設定
* ニフクラ mobile backend の[ドキュメント（クイックスタート）](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_ios.html)をご活用ください

### ロジック
* `Main.storyboard`でデザインを作成し、`ViewController.m`にロジックを書いています

#### 自動ログイン処理
```objc
#import "ViewController.h"
#import <NCMB/NCMB.h>

@interface ViewController ()
// label
@property (weak, nonatomic) IBOutlet UILabel *greetingMessage;
@property (weak, nonatomic) IBOutlet UILabel *lastVisit;
@property (weak, nonatomic) IBOutlet UILabel *dayAndTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // labelの初期化
    self.greetingMessage.text = @"";
    self.lastVisit.text = @"";
    self.dayAndTime.text = @"";

    // UUID取得
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"uuid:%@",uuid);

    [NCMBUser logInWithUsernameInBackground:uuid password:uuid block:^(NCMBUser *user, NSError *error) {
        if (error) {
            // ログイン失敗時の処理
            NSLog(@"ログインに失敗しました。エラーコード：%ld",(long)error.code);
            // 初回利用（会員未登録）の場合
            if (error.code == 401002) { // 401002：ID/Pass認証エラー
                /* mBaaS会員登録 */
                NCMBUser *user = [NCMBUser user];
                user.userName = uuid;
                user.password = uuid;

                [user signUpInBackgroundWithBlock:^(NSError *error) {
                    if (error) {
                        // 会員登録失敗時の処理
                        NSLog(@"会員登録に失敗しました。エラーコード：%ld",(long)error.code);
                    } else {
                        // 会員登録成功時の処理
                        NSLog(@"会員登録に成功しました。");
                        self.greetingMessage.text = @"はじめまして！";

                        /* mBaaSデータの保存 */
                        // 最終ログイン時間をセット
                        [user setObject:user.updateDate forKey:@"lastLoginDate"];
                        [user saveInBackgroundWithBlock:^(NSError *error) {
                            if (error) {
                                // 保存失敗時の処理
                                NSLog(@"最終ログイン日時の保存に失敗しました。エラーコード：%ld",(long)error.code);
                            } else {
                                // 保存成功時の処理
                                NSLog(@"最終ログイン日時の保存に成功しました。");
                            }
                        }];
                    }
                }];
            }
        } else {
            // ログイン成功時の処理
            NSLog(@"ログインに成功しました");

            self.greetingMessage.text = @"おかえりなさい";
            self.lastVisit.text = @"最終ログイン";
            // 最終ログイン日時取得
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss"; // 日付のフォーマット
            self.dayAndTime.text = [formatter stringFromDate:user.updateDate];

            // ログイン日時の上書き
            [user setObject:user.updateDate forKey:@"lastLoginDate"];
            [user saveInBackgroundWithBlock:^(NSError *error) {
                if (error) {
                    // 保存失敗時の処理
                    NSLog(@"最終ログイン日時の保存に失敗しました。エラーコード：%ld",(long)error.code);
                } else {
                    // 保存成功時の処理
                    NSLog(@"最終ログイン日時の保存に成功しました。");
                }
            }];
        }
    }];
}
```

* 同じ内容の【Swift】版もご用意しています
 * https://github.com/NIFCloud-mbaas/SwiftAutoLoginApp
