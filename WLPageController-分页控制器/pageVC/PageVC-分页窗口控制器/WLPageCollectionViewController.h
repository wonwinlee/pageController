//
//  WLPageCollectionViewController.h
 
//  Copyright © 2016年 wonwinlee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WLPageControllerDelegate <NSObject>

@optional

// transition from index to index with animated
/**从一个控制器跳转到另一个控制器及是否设置动画 */
- (void)transitionToIndex:(NSIndexPath *)toIndex;

@end

/**=========================协议end============================= */
@interface WLPageCollectionViewController : UICollectionViewController 


//@property (nonatomic, weak) id<WLPageControllerDataSource> dataSource;
@property (nonatomic, weak) id<WLPageControllerDelegate>   delegate;
/**子控制器的view数组 */
@property (strong,nonatomic) NSMutableArray *subViewArray;


///**从一个控制器跳转到另一个控制器及是否设置动画 */
//- (void)jumpFromIndex:(NSIndexPath *)formIndex toIndex:(NSIndexPath *)toIndex;
@end
