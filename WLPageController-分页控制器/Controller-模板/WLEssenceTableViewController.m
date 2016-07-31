 

#import "WLEssenceTableViewController.h"

#import "WLPageCollectionViewController.h"
#import "WLPageBarCollectionViewController.h"
#import "WLTempVc.h"
#import "WLBarButtonItem.h"

@interface WLEssenceTableViewController ()


/**=====================模板============================= */
@property (strong,nonatomic) WLPageCollectionViewController *PageController ;
@property (strong,nonatomic) WLPageBarCollectionViewController *PageBarController ;
@property (strong,nonatomic) NSMutableArray *subviews;
/**=====================模板============================= */

@property (strong,nonatomic) NSArray *titlesArray;
@end

@implementation WLEssenceTableViewController
/**=====================模板2============================= */
- (NSMutableArray *)subviews
{
    if (!_subviews) {
        _subviews = [NSMutableArray array];
    }
    return _subviews;
}
/**=====================模板2============================= */
- (void)viewDidLoad {

    [super viewDidLoad];
    //初始化分页控制器
    [self setupPageController];
    // 初始化navigationItem
    [self setupnavigationItem];
}
// 初始化navigationItem
- (void)setupnavigationItem{
    //左边navigationItem
    WLBarButtonItem * leftItem = [WLBarButtonItem itemWithButtonImage:[UIImage imageNamed:@"nav_item_game_icon"] andHighLightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem= leftItem;
    //中间navigationItem
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //右边navigationItem
    WLBarButtonItem * rightItem = [WLBarButtonItem itemWithButtonImage:[UIImage imageNamed:@"navigationButtonRandom"] andHighLightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)leftItemClick
{
    NSLog(@"%s,Line=%d,[%@]",__func__,__LINE__,[NSThread currentThread]);
}

- (void)rightItemClick
{
    NSLog(@"%s,Line=%d,[%@]",__func__,__LINE__,[NSThread currentThread]);
}
/**=====================模板3============================= */
- (void)setupPageController {
    
    self.view.backgroundColor = [UIColor cyanColor];
     // 设置titles一共九个模块
    self.titlesArray = @[@"全部",@"视频",@"图片",@"段子",@"网红",@"排行",@"社会",@"美女",@"游戏"];
    /**======================WLPageCollectionViewController====================== */
    
    WLPageCollectionViewController *PageController = [[WLPageCollectionViewController alloc] init];
    // 禁用自动滚回顶部功能 -- 为了让内部的tableview具有自动滚回顶部功能
    PageController.collectionView.scrollsToTop = NO;
    // 这一步必须有, 因为内部的子控件需要self的导航控制器
    [self addChildViewController:PageController];
    // 保存
     self.PageController = PageController;
    // 设置尺寸
    PageController.view.frame=self.view.bounds;
    // 添加view
    [self.view addSubview:PageController.view];
  
    //给PageController添加子控制器
    [self pageVCAddChildViewController];
    /**=====================WLPageBarCollectionViewController======================== */
 
    WLPageBarCollectionViewController *PageBarController = [[WLPageBarCollectionViewController alloc] init];
     PageBarController.titlesArray = self.titlesArray;
     self.PageBarController = PageBarController;
    // 禁用自动滚回顶部功能 -- 为了让内部的tableview具有自动滚回顶部功能
    PageBarController.collectionView.scrollsToTop = NO;

    PageBarController.view.frame=CGRectMake(0, 64, kScreenWidth, 35);
    PageBarController.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    [self.view addSubview:PageBarController.view];


    /**========================这里的警告可以忽略========================= */
    PageBarController.delegate = self.PageController;
    PageController.delegate = PageBarController;
    /**========================这里的警告可以忽略========================= */
 
}
/**=====================模板3============================= */
//添加子控制器和子控制器的view
- (void)pageVCAddChildViewController
{

    for (int i = 0; i < 9; i++) {
        
        WLTempVc *videoVc = [[WLTempVc alloc] init];
        videoVc.title = self.titlesArray[i];
        videoVc.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) /255.0) blue:(arc4random_uniform(255) /255.0) alpha:1.0f];
        // 把子控制器添加到pagecontroler
        [self.PageController addChildViewController:videoVc];
        // 把view添加到临时数组中保存
        [self.subviews addObject:videoVc.view];
    }
    //把子控制器的view给PageController
    self.PageController.subViewArray = self.subviews;
}


@end
