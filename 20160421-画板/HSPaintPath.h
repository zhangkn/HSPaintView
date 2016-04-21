//
//  HSPaintPath.h
//  20160421-画板
//
//  Created by devzkn on 4/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPaintPath : UIBezierPath
@property (nonatomic,strong) UIColor *color;

/**
 提供类方法，返回数据模型数组--工厂模式
 */
- (instancetype) initWithColor:(UIColor *) color lineWidht:(CGFloat)width startPoint:(CGPoint)point;
+ (instancetype) pathWithColor:(UIColor *) color lineWidht:(CGFloat)width startPoint:(CGPoint)point;


@end
