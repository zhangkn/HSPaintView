//
//  HSHandleImageView.h
//  20160421-画板
//
//  Created by devzkn on 4/22/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HSHandleImageViewBlock) (UIImage *image);
@interface HSHandleImageView : UIView
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) HSHandleImageViewBlock block;

@end
