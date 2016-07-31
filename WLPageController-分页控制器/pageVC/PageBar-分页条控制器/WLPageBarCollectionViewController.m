//
//  WLPageBarCollectionViewController.m
 
//  Copyright © 2016年 wonwinlee. All rights reserved.
//
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#import "WLPageBarCollectionViewController.h"

#import "WLPageCollectionViewController.h"

#import "WLPageBarCollectionViewCell.h"


@interface WLPageBarCollectionViewController () <WLPageControllerDelegate>


@property (strong,nonatomic) NSIndexPath *selectIndexPath;

@property (strong,nonatomic) UIView * lineView ;
@end

@implementation WLPageBarCollectionViewController

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
    flowLayout.itemSize = CGSizeMake(screenW/6, 35);
    
    // 设置滚动方向 水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 配置collection
    self.collectionView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*10, 0);
 
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    // 添加指示下划线
    UIView * lineView = [[UIView alloc] init];
    
    lineView.frame = CGRectMake(15, 33, screenW/6-30, 2);
    
    lineView.backgroundColor = [UIColor redColor];
    
    [self.collectionView addSubview:lineView];
    // 保存lineview
    self.lineView = lineView;
    // Register cell classes
    [self.collectionView registerClass:[WLPageBarCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>
//定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 10;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titlesArray.count;
}
//每个UICollectionView展示的内容----添加所有子控制器和子控制器的view
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WLPageBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    cell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) /255.0) blue:(arc4random_uniform(255) /255.0) alpha:1.0f];
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    cell.label.text = self.titlesArray[indexPath.row];
 
    //判断是否为选中的cell
    if (indexPath == self.selectIndexPath) {
        //把选中的改为红色
        cell.label.textColor = [UIColor redColor];
    } else {
        //把选中的改为红色
        cell.label.textColor = [UIColor blackColor];
    }
 
    return cell;
}


#pragma mark <UICollectionViewDelegate>



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   NSLog(@"%@",indexPath);
    //把之前的改为黑色
    WLPageBarCollectionViewCell *preCell = (WLPageBarCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.selectIndexPath];
    preCell.label.textColor = [UIColor blackColor];

    //把选中的改为红色
    WLPageBarCollectionViewCell *cell = (WLPageBarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor redColor];
    // 保存选中的索引
    self.selectIndexPath = indexPath;
    /**=================让选中的按钮居中显示==================== */
    [self setUpTitleBtnMiddle:cell];
    /**=================调整lineView的位置==================== */
    [UIView animateWithDuration:0.25 animations:^{
        
        self.lineView.center = CGPointMake(cell.center.x, self.lineView.center.y);
    }];
    /**=================让WLPageCollectionViewController滑动到对应的view==================== */
//    
//    if ([self.delegate respondsToSelector:@selector(jumptoIndex:)]) {
//        
//        [self.delegate jumptoIndex:indexPath.row];
//    }

}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /**=================让WLPageCollectionViewController滑动到对应的view==================== */
    
    if ([self.delegate respondsToSelector:@selector(jumptoIndex:)]) {
        
//        [self.delegate jumptoIndex:indexPath.row];
        [self.delegate jumptoIndex:indexPath];
    }
    return YES;
}
//// 设置标题按钮居中
- (void)setUpTitleBtnMiddle:(WLPageBarCollectionViewCell *)cell
{
    
    // 计算偏移量==按钮相对于中心的位置
    CGFloat offsetX = cell.center.x - screenW * 0.5;
    
    // 左边偏移多了，表示需要往左边看，可视范围往左边，偏移量就减少，最少应该是0
    if (offsetX < 0) offsetX = 0;
    CGFloat maxOffsetX = self.collectionView.contentSize.width - screenW;
    
    // 右边偏移多了，表示需要往右边看，可视范围往又边，偏移量就增加，最大不超过内容范围 - 屏幕宽度
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}
#pragma mark - 拿到数据, 刷新数据
- (void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
    
    [self.collectionView reloadData];
}
/**从一个控制器跳转到另一个控制器及是否设置动画 */
- (void)transitionToIndex:(NSIndexPath *)toIndex{
    
   [self collectionView:self.collectionView didSelectItemAtIndexPath:toIndex];
    

}


@end
