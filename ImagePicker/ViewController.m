//
//  ViewController.m
//  ImagePicker
//
//  Created by MAEDA HAJIME on 2014/04/04.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//
@property (weak, nonatomic) IBOutlet UIImageView *ivImage;

@property (weak, nonatomic) IBOutlet UISegmentedControl *scSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // カメラ有無判定
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]) {
        
        // [Camera]ボタン無効化 NO:使えない @property *scSource;
        [self.scSource setEnabled:NO forSegmentAtIndex:1];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 参照元セグメント変更
- (IBAction)changeSource:(UISegmentedControl *)sender {
        
    // UIImagePickerControllerオブジェクト生成
    UIImagePickerController *ip = [UIImagePickerController new];
    
    // 設定（ソースタイプ）
    switch (sender.selectedSegmentIndex) {
        case 0:  // フォトライブラリー（アルバム一覧）
            ip.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1:  // カメラ
            // カメラ有無判定
            if (![UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera]) {
                
                NSLog(@"カメラは使えません。");
                return;
            }
            ip.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 2:  // フォトアルバム（カメラロール）
            ip.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
            
        default:
            break;
    }
    // 設定（デリゲート）
    ip.delegate = self;
    
    // イメージピッカービューを開く
    [self presentViewController:ip
                       animated:YES
                     completion:nil];
    
}

# pragma mark - UIImagePickerControllerDelegate
// 画像の取得時
- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 画像表示
    self.ivImage.image = info[UIImagePickerControllerOriginalImage];
    
    // イメージピッカー閉じる
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
