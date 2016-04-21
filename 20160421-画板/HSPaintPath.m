//
//  HSPaintPath.m
//  20160421-画板
//
//  Created by devzkn on 4/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HSPaintPath.h"

@implementation HSPaintPath
- (instancetype)initWithColor:(UIColor *)color lineWidht:(CGFloat)width startPoint:(CGPoint)point{
    self = [super init];//初始化父类属性
    if (self) {
        //初始化自身属性
        [self setLineWidth:width];
        [self setColor:color];
        [self moveToPoint:point];        
    }
    return self;
}
+ (instancetype)pathWithColor:(UIColor *)color lineWidht:(CGFloat)width startPoint:(CGPoint)point{
    return [[self alloc]initWithColor:color lineWidht:width startPoint:point];
}


@end
