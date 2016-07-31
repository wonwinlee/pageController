//
//  WLPageBarCollectionViewCell.m
 
//  Copyright © 2016年 wonwinlee. All rights reserved.
//

#import "WLPageBarCollectionViewCell.h"


@implementation WLPageBarCollectionViewCell
//
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        
        label.bounds =CGRectMake(0, 0, self.contentView.bounds.size.width, 33);
        label.center = self.contentView.center;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        //
        [self.contentView addSubview:label];
        
        self.label = label;
    }
    return self;
}


@end
