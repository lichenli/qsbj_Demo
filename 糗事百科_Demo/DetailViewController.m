//
//  DetailViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BaseView.h"
#import "CommentItems.h"
@interface DetailViewController ()
{
    ThemeUimageView * barBaseview;
}
@end

@implementation DetailViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:kNSNotificationTheme];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 主题背景图片
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeimage) name:kNSNotificationTheme object:nil];
    }
    return self;
    
}
#pragma mark - 主题背景
-(void)changeimage
{
    UIImage * image = [[ThemeManger shareinster] loadImage:@"main_background@2x.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeimage];
    // 1. 添加navigationBar
    [self initnavigtionBar];
    
    // 2. 初始化tableviewHeadView
    [self initTableviewHeadview];
    
    // 3. 加载数据
    [self loadData];
    
    // 4. 下拉刷新
    __block DetailViewController * this = self;
    self.tableview.pullDownBlock = ^(UITableView * tableView){
        // 数据请求
        [this loadData];
    };
    // 5. 上拉刷新
    self.tableview.pullUpBlock = ^(UITableView * tableView){
        [this loadDataMore];
    };
    
}
#pragma mark - tableview HeadView
-(void)initTableviewHeadview
{
    float hight = [BaseView loadBaseViewHeight:self.items];
    BaseView * baseview = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, 320, hight)];
    self.tableview.tableHeaderView = baseview;
    baseview.items = self.items;
    
    // 设置tableview的分割线
    UIImage * image = [[ThemeManger shareinster] loadImage:@"block_line@2x.png"];
    self.tableview.separatorColor =[UIColor colorWithPatternImage:image];

}


#pragma mark - 设置navigtionBar的样式
-(void)initnavigtionBar
{
    // 设置电池条的样式
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    // 添加主题navigationBar
    barBaseview = [[ThemeUimageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 44)];
    barBaseview.userInteractionEnabled = YES;
    barBaseview.imageName = @"head_background.png";
    [self.navigationController.view addSubview:barBaseview];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    title.center = barBaseview.center;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:20];
    title.text = @"糗事";
    [barBaseview addSubview:title];
    
    // 添加button
    ThemeButton * leftbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(8, 5, 0, 0);
    leftbutton.imageName = @"icon_back_enable@2x.png";
    [leftbutton sizeToFit];
    [leftbutton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    [barBaseview addSubview:leftbutton];
    
    ThemeButton * rightbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(280, 5, 0, 0);
    rightbutton.imageName = @"icon_share@2x.png";
    [rightbutton sizeToFit];
    [barBaseview addSubview:rightbutton];
    
    // 添加阴影效果
    barBaseview.layer.shadowColor = [UIColor blackColor].CGColor;
    barBaseview.layer.shadowOpacity = 0.6;
    barBaseview.layer.shadowOffset = CGSizeMake(0, 1);
    barBaseview.layer.shadowPath = [UIBezierPath bezierPathWithRect:barBaseview.bounds].CGPath;
    
}

#pragma mark - 网络请求 添加数据源
-(void)loadData
{
    __weak NSString * str = self.items.itemsIdentifier;
    
    __weak NSString * string = [NSString stringWithFormat:@"/article/%@/comments",str];
    // 上拉刷新先清空数据源
    self.tableview.dataArray = nil;
    
    QSEngine * engine = [[QSEngine shareEngine] initWithHostName:kURL customHeaderFields:nil];
    
    [engine requestWithURL:string
                    params:nil
                httpMethod:@"GET"
                     blcok:^(MKNetworkOperation * result) {
                         
                         NSArray * array = [result.responseJSON objectForKey:@"items"];
                         NSMutableArray * weiboArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
                         
                         for (NSDictionary * dic in array) {
                             CommentItems * items = [[CommentItems alloc] initWithDictionary:dic];
                             [weiboArray addObject:items];
                         }
                         self.tableview.dataArray = weiboArray;
                         [self.tableview reloadData];
                     }
              errorHandler:^(NSError *error) {}];
    page = 2;
}
static int page = 2;
#pragma mark - 上拉刷新添加数据源
-(void)loadDataMore
{
    __weak NSString * str = self.items.itemsIdentifier;
    __weak NSString * string = [NSString stringWithFormat:@"/article/%@/comments",str];
    // 上拉刷新先清空数据源
    
    QSEngine * engine = [[QSEngine shareEngine] initWithHostName:kURL customHeaderFields:nil];
    NSNumber * number = [NSNumber numberWithInt:page];
    page++;
    NSMutableDictionary * Dics = [NSMutableDictionary dictionaryWithObject:number forKey:@"page"];
    
    [engine requestWithURL:string
                    params:Dics
                httpMethod:@"GET"
                     blcok:^(MKNetworkOperation * result) {
                         
                         // Tableview数据源
                         NSArray * array = [result.responseJSON objectForKey:@"items"];
                         NSMutableArray * weiboArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
                         
                         for (NSDictionary * dic in array) {
                             CommentItems * items = [[CommentItems alloc] initWithDictionary:dic];
                             [weiboArray addObject:items];
                         }
                         [self.tableview.dataArray addObjectsFromArray:weiboArray];
                         [self.tableview reloadData];
                         
                         // 提示用户没有评论了
                         if (array.count < 1) {
                             [self showHUD:@"没有更多评论" withHiddenDelay:2 withView:self.tableview];

                         }
                     }
              errorHandler:^(NSError *error) {}];
}


#pragma mark - 返回
-(void)pushBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 取消滑动
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];      // 手势操作区域
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];      // 手势操作区域
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];      // 手势操作区域
    
    [UIView animateWithDuration:0.35 animations:^{
        barBaseview.left = 320;
    } completion:^(BOOL finished) {
        [barBaseview removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableview:nil];
    [super viewDidUnload];
}
@end
