//
//  ViewController.m
//  20160421-画板
//
//  Created by devzkn on 4/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "ViewController.h"
#import "HSPaintView.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet HSPaintView *paintView;

@end

@implementation ViewController
- (IBAction)lineWidthValueChange:(UISlider *)sender {
    [self.paintView setLineWidth:sender.value];
}
- (IBAction)colorClick:(UIButton *)sender {
    [self.paintView setColor:sender.backgroundColor];
    
}
#pragma mark - 清屏
- (IBAction)cleanScreen:(UIBarButtonItem *)sender {
    [self.paintView cleanScreen];
    
}
- (IBAction)undo:(UIBarButtonItem *)sender {
    [self.paintView undo];
}
- (IBAction)eraserClick:(UIBarButtonItem *)sender {
    [self.paintView setColor:[UIColor whiteColor]];
}
#pragma mark - 从相册选择照片
- (IBAction)selectedPicture:(UIBarButtonItem*)sender {
    //去用户相册
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    /*
     UIImagePickerControllerSourceTypePhotoLibrary,相簿，默认值
     UIImagePickerControllerSourceTypeCamera,//真机测试
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    [pickerVc setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];//照片
    //modal
    //设置代理
    [pickerVc setDelegate:self];
    [self presentViewController:pickerVc animated:YES completion:^{
        //
    }];
    
}
#pragma mark - UIImagePickerControllerDelegate
// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
#if 0
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{// NS_DEPRECATED_IOS(2_0, 3_0)
    NSLog(@"%s",__func__);
}
#endif

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    /**
     {
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x7ae83b30> size {3000, 2002} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=ED7AC36B-A150-4C38-BB8C-B6D696F4F2ED&ext=JPG";
     }
     */
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.paintView setImage:image];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.paintView.frame];
//    [imageView setImage:image];
//    [self.paintView addSubview:imageView];
    
    NSLog(@"%@",info);
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

#pragma mark 保存图片
- (IBAction)save:(UIBarButtonItem *)sender {
    [self.paintView save];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
