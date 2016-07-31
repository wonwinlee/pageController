# pageController
封装了导航条TabBar带有透明效果的分页控制器
WLPageController

iOS分页控制器,只需传入标题数组和控制器类名数组即可.

版本说明

现在使用自由文本宽度作为tagSize时,指示条宽度能随文本宽度变化而变化了
修复了某些情况下,指示条显示不正确的问题
特性

直接继承WLPageCollectionView控制器即可,所有属性及方法可通过点语法调用
增加了控制器缓存,并可自定义缓存时间,一段时间内未被重新展示的标签对应的控制器将被销毁(详见属性说明)
实现效果图如下: 

效果图

使用方法

在项目中导入WLPageController文件夹(包含MVC,及常量定义文件).

自定义一个控制器继承WLPageController:

@interface ViewController : WLPageController


@end
重载自定义控制器的init方法(从代码和xib,SB创建的请重载initWithCoder:):

//代码创建
- (instancetype)init
{

    self = [super initWithTagViewHeight:49];
    if (self) {

    }
    return self;
}
4.在之后的viewDidLoad中可以设置相关属性,具体属性说明参见下文说明或者查看头文件,由于存在继承关系,可以直接根据self点语法使用,部分示例如下:

self.tagItemSize = CGSizeMake(100, 49);
self.selectedTitleColor = [UIColor blueColor];

self.graceTime = 300;
部分属性方法说明

字体及颜色

normalTitleFont: 正常(非选中)标签字体 default is 14,

selectedTitleFont: 选中状态标签字体 default is 16,

normalTitleColor: 正常(非选中)标签字体颜色 default is darkGrayColor,

selectedTitleColor: 选中状态标签字体颜色 default is redColor,
selectedIndicatorColor: 下方滑块颜色 default is redColor,
tagItemSize: 每个tag标签的size,如果不设置则会根据文本长度计算,目前只有设置该属性滑动指示条才能跟随手势拖动,其他情况下暂未实现,欢迎提供实现方案
tagItemGap:根据文本计算tag宽度时,每个tag之间的间距,default is 10,

selectedIndicatorSize:如果tag设置了tagItemSize,则宽度默认跟tagItemSize宽度相同(也可手动更改),如果tag使用文本宽度,则必须手动设置该属性,否则将默认为(50,2)

graceTime:控制器缓存时间,如果在该段时间内缓存的控制器依旧没有被展示,则会从内存中销毁,默认不设置,即默认在内存中缓存所有展示过的控制器

gapAnimated:跨越多个标签进行切换时,page是否动画,默认为NO,建议不开启,开启后中间过渡的控制器都会加载
backgroundColor: 标签展示的背景色
刷新方法:

-(void)reloadDataWith:(NSArray *)titleArray andSubViewdisplayClasses:(NSArray *)classes
-(void)reloadDataWith:(NSArray *)titleArray andSubViewdisplayClasses:(NSArray *)classes withParams:(NSArray *)params;