//
//  WLPageCollectionViewController.m
 
//  Copyright © 2016年 wonwinlee. All rights reserved.
//
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#import "WLPageCollectionViewController.h"
#import "WLPageBarCollectionViewController.h"


@interface WLPageCollectionViewController () <WLPageBarControllerDelegate>

@property (strong,nonatomic) NSIndexPath *selectIndexPath;

@property (assign,nonatomic) CGPoint preOffset ;

@end

@implementation WLPageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
// 1.创建布局参数

// 2.注册cell

// 3.自定义cell
/**初始化流水布局 */
- (instancetype)init{
    // 创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 行间距
    flowLayout.minimumLineSpacing = 0;
    // 每个item 之间的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    // 设置每个cell 的尺寸
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 设置滚动方向 水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //    flowLayout.sectionInset = UIEdgeInsetsMake(100, 20, 30, 40);
    
    return [super initWithCollectionViewLayout:flowLayout];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // 配置collection
    self.collectionView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*10, [UIScreen mainScreen].bounds.size.height);
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>
//定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 10;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.subViewArray.count;
}
//每个UICollectionView展示的内容----添加所有子控制器和子控制器的view
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    /**把对应子控制器的view添加到cell上 */
    UIView *subview  = self.subViewArray[indexPath.row];
    subview.frame = cell.contentView.bounds;
    [cell.contentView addSubview:subview];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//CGFloat f = -123;
//fabs(f);
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    //判断滚动后的偏移量是否大于屏幕的一半, 如果小于则直接返回
    if (fabs(scrollView.contentOffset.x-self.preOffset.x)<kScreenWidth/2) {
        return;
    }
    /**=================让WLPageBarCollectionViewController滑动到对应的view==================== */
    
    if ([self.delegate respondsToSelector:@selector(transitionToIndex:)]) {
        
        [self.delegate transitionToIndex:self.selectIndexPath];
    }
    
    self.preOffset = offset;
}


//-(void)setSubViewArray:(NSMutableArray *)subViewArray
//{
//    _subViewArray = subViewArray;
//    // 刷新数据
////    [self.collectionView reloadData];
//}
#pragma mark -
/**从一个控制器跳转到另一个控制器及是否设置动画 */
- (void)jumptoIndex:(NSIndexPath *)toIndex{
        //
    self.collectionView.contentOffset = CGPointMake(screenW*toIndex.row, 0);

}






@end
