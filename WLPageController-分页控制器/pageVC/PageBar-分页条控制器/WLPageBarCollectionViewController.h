//
//  WLPageBarCollectionViewController.h
 
//  Copyright © 2016年 wonwinlee. All rights reserved.
//

#import <UIKit/UIKit.h>

/**=========================代理协议============================= */

@protocol WLPageBarControllerDelegate <NSObject>

@optional

// transition from index to index with animated
/**从一个控制器跳转到另一个控制器及是否设置动画 */
- (void)jumptoIndex:(NSIndexPath *)toIndex;

@end

/**=========================协议end============================= */
@interface WLPageBarCollectionViewController : UICollectionViewController

@property (strong,nonatomic) NSArray *titlesArray;

@property (weak, nonatomic) id<WLPageBarControllerDelegate> delegate;
@end
