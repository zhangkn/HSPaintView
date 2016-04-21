//
//  HSPaintView.m
//  20160421-画板
//
//  Created by devzkn on 4/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HSPaintView.h"
#import "HSPaintPath.h"
#import "MBProgressHUD+MJ.h"

@interface HSPaintView ()
@property (nonatomic,strong) HSPaintPath *path;//存储当前触摸的路径
@property (nonatomic,strong) NSMutableArray *paths;//存储历史的路径


@end

@implementation HSPaintView

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
    
}

- (void)cleanScreen{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
    
}
- (void)undo{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
    
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
}

- (void) setColor:(UIColor *)color{
    _color = color;
}

- (NSMutableArray *)paths{
    if (nil == _paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

/**     获取触摸点*/
- (CGPoint) pointWithTouches:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.path = [HSPaintPath pathWithColor:self.color lineWidht:self.lineWidth startPoint:[self pointWithTouches:touches]];
    [self.paths addObject:self.path];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //确定终点
    [self.path addLineToPoint:[self pointWithTouches:touches]];
    [self setNeedsDisplay];
}
#pragma mark - 绘制状态
- (void)drawRect:(CGRect)rect{
    if (!self.paths.count) {
        return;
    }
    for (HSPaintPath *path in self.paths) {
        if ([path  isKindOfClass:[UIImage class]]) {
            //画图片
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            //设置绘制状态
            [path.color set];
            //描边
            [path stroke];
        }
    }
}

#pragma mark -初始化绘制状态
- (void)awakeFromNib{
    self.lineWidth = 2;
}

#pragma mark - 保存到用户相册
- (void)save{
    //1.截屏
    UIGraphicsBeginImageContext(self.bounds.size);
    //渲染
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    //2.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //3.关闭
    UIGraphicsEndImageContext();
    //4\保存
    //    NSData *data = UIImagePNGRepresentation(newImage);
    //    [data writeToFile:@"/Users/devzkn/Desktop/layer.png" atomically:YES];
    //保存到用户相册里面
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), context);    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"%s",__func__);
    if (error) {
        //保存失败
        [MBProgressHUD showError:@"保存失败"];

    }else{
        [MBProgressHUD showSuccess:@"保存成功"];
    }
    
}


@end
