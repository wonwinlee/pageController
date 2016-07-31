 
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#import "WLViewController.h"

#import "WLPageCollectionViewController.h"
#import "WLPageBarCollectionViewController.h"

#import "WLTempVc.h"
#import "WLBarButtonItem.h"


@interface WLViewController ()
/**=====================模板1============================= */
@property (strong,nonatomic) WLPageCollectionViewController *PageController ;

@property (strong,nonatomic) NSMutableArray *subviews;
/**=====================模板1============================= */
@end

@implementation WLViewController
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
    
    
    [self setup];
}
/**=====================模板3============================= */
- (void)setup {
    
    self.view.backgroundColor = [UIColor cyanColor];
   
    /**======================WLPageCollectionViewController====================== */
    WLPageCollectionViewController *PageController = [[WLPageCollectionViewController alloc] init];
    
    [self addChildViewController:PageController];
    // 这里y设为0 如果有导航条的话会自动向下偏移64
    PageController.view.frame=CGRectMake(0, 0, screenW, screenH);

    [self.view addSubview:PageController.view];
    
    self.PageController = PageController;
    //给PageController添加子控制器
    [self pageVCAddChildViewController];

    
    self.PageController.subViewArray = self.subviews;
    /**=====================WLPageBarCollectionViewController======================== */
    WLPageBarCollectionViewController *PageBarController = [[WLPageBarCollectionViewController alloc] init];
    
    [self addChildViewController:PageBarController];
    // 这里y设为0 如果有导航条的话会自动向下偏移64
    PageBarController.view.frame=CGRectMake(0, 64, screenW, 35);

    [self.view  addSubview:PageBarController.view];
    // 设置titles
    PageBarController.titlesArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];

    
/**========================这里的警告可以忽略========================= */
    PageBarController.delegate = self.PageController;
    PageController.delegate = PageBarController;
/**========================这里的警告可以忽略========================= */
    

}
/**=====================模板3============================= */

#pragma mark - collectionView dataSource

//添加子控制器和控制器的view
- (void)pageVCAddChildViewController
{
    
//    /**==========================VideoViewController================================== */
//    for (int i = 0; i < 9; i++) {
//        
//        WLTempVc *videoVc = [[WLTempVc alloc] init];
//        videoVc.title = self.titlesArray[i];
//        videoVc.view.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) /255.0) blue:(arc4random_uniform(255) /255.0) alpha:1.0f];
//        // 把子控制器添加到pagecontroler
//        [self.PageController addChildViewController:videoVc];
//        // 把view添加到临时数组中保存
//        [self.subviews addObject:videoVc.view];
//    }
}
/**=====================模板============================= */
@end
