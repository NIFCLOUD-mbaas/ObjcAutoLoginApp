//
//  ViewController.m
//  ObjcAutoLoginApp
//
//  Created by FJCT on 2016/11/24.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
