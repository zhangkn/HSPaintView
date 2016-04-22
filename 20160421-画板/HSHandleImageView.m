//
//  HSHandleImageView.m
//  20160421-画板
//
//  Created by devzkn on 4/22/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HSHandleImageView.h"

@interface HSHandleImageView ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) UIImageView *imageView;

@end


@implementation HSHandleImageView

- (UIImageView *)imageView{
    if (nil == _imageView) {
        UIImageView *tmpView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView = tmpView;
        [_imageView setUserInteractionEnabled:YES];
        [self addSubview:_imageView];
    }
    return _imageView;
}

#if 1
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自己的属性
        [self addUILongPressGestureRecognizer];
        [self addUIRotationGestureRecognizer];
        [self addUIPinchGestureRecognizer];
        
    }
    return self;
}
#endif

#pragma mark - 添加手势识别器
- (void) addUILongPressGestureRecognizer{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [longPress setDelegate:self];
    [self.imageView addGestureRecognizer:longPress];
}

- (void) addUIRotationGestureRecognizer{
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGR:)];
    [rotationGR setDelegate:self];
    [self.imageView addGestureRecognizer:rotationGR];
}

#pragma mark - rotation
- (void) rotationGR:(UIRotationGestureRecognizer*)rotationGR{
    NSLog(@"%s",__func__);
    [self.imageView setTransform:CGAffineTransformRotate(self.imageView.transform, rotationGR.rotation)];
    [rotationGR setRotation:0];
    
}

- (void) addUIPinchGestureRecognizer{
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGR:)];
    [pinchGR setDelegate:self];
    [self.imageView addGestureRecognizer:pinchGR];}


- (void) pinchGR:(UIPinchGestureRecognizer*)pinchGR{
    NSLog(@"%s",__func__);
    [self.imageView setTransform:CGAffineTransformScale(self.imageView.transform, pinchGR.scale, pinchGR.scale)];
    [pinchGR setScale:1];
    
    
}

#pragma mark - 长按处理
- (void) longPress:(UILongPressGestureRecognizer*)longPressGR{
    if (longPressGR.state == UIGestureRecognizerStateEnded) {
        //动画
        [UIView animateWithDuration:0.5 animations:^{
            //设置透明度
            [self.imageView setAlpha:0.3];
        } completion:^(BOOL finished) {
            //还原透明度
            [UIView animateWithDuration:0.5 animations:^{
                [self.imageView setAlpha:1.0];
            }completion:^(BOOL finished) {
                //1、截屏
                UIGraphicsBeginImageContext(self.bounds.size);
                [self.layer renderInContext:UIGraphicsGetCurrentContext()];
                UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //2.将图片传递给VC，进行渲染--使用block
                self.block(newImage);
                //3销毁自己
                [self removeFromSuperview];
            }];
        }];
    
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.imageView setImage:image];
}


#pragma mark - gestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}





@end
