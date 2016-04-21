//
//  HSPaintView.h
//  20160421-画板
//
//  Created by devzkn on 4/21/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPaintView : UIView
@property (nonatomic,assign) CGFloat lineWidth;//绘制状态的线宽
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIImage *image;


- (void) cleanScreen;
- (void) undo;
- (void) save;





@end
