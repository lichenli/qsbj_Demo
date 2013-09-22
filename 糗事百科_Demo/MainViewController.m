//
//  MainViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//  主页面

#import "MainViewController.h"
#import "SendViewController.h"

@interface MainViewController ()
{
    ThemeUimageView * baseview;
    ThemeUimageView * titleview;    //titleview
    ThemeButton * selectbuton;      //选中view
}


@end
@implementation MainViewController


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
                
        // titleArr
        _styleArr = [[NSMutableArray alloc]init];
        
        // 初始化启动的URL
        _URLstring = URLgan;
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
    
    // 1. 设置navigtionBar的样式
    [self initnavigtionBar];
    
    // 2. 网络请求 添加数据源
    [self loadData];
    
    // 3. 下拉刷新
    __block MainViewController * this = self;
    self.tableview.pullDownBlock = ^(UITableView * tableView){
        // 数据请求
        [this loadData];
    };
    // 4. 上拉刷新
    self.tableview.pullUpBlock = ^(UITableView * tableView){
        [this loadDataMore];
    };

}
#pragma mark - 从XIB加载
-(void)awakeFromNib
{
    [self loadData];
}


#pragma mark - 设置navigtionBar的样式
-(void)initnavigtionBar
{
    // 设置电池条的样式
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    // 添加主题navigationBar
    baseview = [[ThemeUimageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 44)];
    baseview.userInteractionEnabled = YES;
    baseview.imageName = @"head_background.png";
    [self.navigationController.view addSubview:baseview];
    
    
    // 添加button
    ThemeButton * leftbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    [leftbutton addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.frame = CGRectMake(8, 5, 0, 0);
    leftbutton.imageName = @"side_icon@2x.png";
    [leftbutton sizeToFit];
    [baseview addSubview:leftbutton];
    
    // 发送button
    ThemeButton * rightbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(280, 5, 0, 0);
    [rightbutton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.imageName = @"icon_post_enable@2x.png";
    [rightbutton sizeToFit];
    [baseview addSubview:rightbutton];

    // 添加阴影效果
    baseview.layer.shadowColor = [UIColor blackColor].CGColor;
    baseview.layer.shadowOpacity = 0.6;
    baseview.layer.shadowOffset = CGSizeMake(0, 1);
    baseview.layer.shadowPath = [UIBezierPath bezierPathWithRect:baseview.bounds].CGPath;
    
    // 切换URL title
    [self URLselectButton];
    
}

#pragma mark  切换URL title
-(void)URLselectButton
{
    // 切换URLbutton
    titleview = [[ThemeUimageView alloc] init];
    titleview.imageName = @"top_tab_background3@2x.png";
    titleview.userInteractionEnabled = YES;
    [titleview sizeToFit];
    titleview.center = baseview.center;
    [baseview addSubview:titleview];
    
    _styleArr = [NSMutableArray arrayWithObjects:@"干货",@"嫩草",@"附近", nil];

    for (int i = 0 ; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.textColor = [UIColor brownColor];
        btn.frame = CGRectMake(0, 0, 60, 29);
        [btn setTitle:_styleArr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0 ,0 , 60, 29);
        btn.center = CGPointMake(titleview.size.width/ 6 *(1 + 2 * i), titleview.size.height/ 2);
        [btn addTarget:self action:@selector(selectTabbar:) forControlEvents:UIControlEventTouchUpInside];
        [titleview addSubview:btn];
        selectbuton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    // 选中button
    selectbuton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    selectbuton.userInteractionEnabled = NO;
    selectbuton.BGimageName = @"top_tab_active@2x.png";
    [selectbuton setTitle:@"干货" forState:UIControlStateNormal];
    selectbuton.titleLabel.font = [UIFont systemFontOfSize:13];
    selectbuton.frame = CGRectMake(0, 0, 60, 29);
    selectbuton.center = CGPointMake(titleview.size.width/ 6, titleview.size.height/ 2);
    [titleview addSubview:selectbuton];
    
}
#pragma mark - 干货 嫩草 位置信息
-(void)selectTabbar:(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        selectbuton.center = button.center;
    } completion:^(BOOL finished) {
        selectbuton.titleLabel.text = button.titleLabel.text;
    }];
    
    // 随便逛逛
        switch (button.tag) {
            case 100:
                _URLstring = URLgan;
                [self loadData];
                break;
                
            case 101:
                _URLstring = URLnen;
                [self loadData];
                break;
                
            case 102:
                _URLstring = URLnear;
                [self loadData];
                break;
                
            default:
                break;
        }

}

#pragma mark - 打开leftVC 的button方法
-(void)open
{
    if (self.mm_drawerController.openSide == MMDrawerSideLeft) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        }];
    }else{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
    }];
    }
}

#pragma mark - push 发送界面
-(void)send
{
    SendViewController * sendVC =[[SendViewController alloc]init];
    [self.navigationController pushViewController:sendVC animated:YES];
}

#pragma mark - 网络请求 添加数据源
-(void)loadData
{
    // 上拉刷新先清空数据源
    self.tableview.dataArray = nil;
    
    QSEngine * engine = [[QSEngine shareEngine] initWithHostName:kURL customHeaderFields:nil];
    
    [engine requestWithURL:_URLstring
                    params:nil
                httpMethod:@"GET"
                     blcok:^(MKNetworkOperation * result) {
                         
                         NSArray * array = [result.responseJSON objectForKey:@"items"];
                         NSMutableArray * weiboArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
                         
                         for (NSDictionary * dic in array) {
                             QSModelItems * items = [[QSModelItems alloc] initWithDictionary:dic];
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
    QSEngine * engine = [[QSEngine shareEngine] initWithHostName:kURL customHeaderFields:nil];
    NSLog(@"%d",page);
    NSNumber * number = [NSNumber numberWithInt:page];
    page++;
    NSMutableDictionary * Dics = [NSMutableDictionary dictionaryWithObject:number forKey:@"page"];
    
    [engine requestWithURL:_URLstring
                    params:Dics
                httpMethod:@"GET"
                     blcok:^(MKNetworkOperation * result) {
                         
                         // Tableview数据源
                         NSArray * array = [result.responseJSON objectForKey:@"items"];
                         NSMutableArray * weiboArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
                         
                         for (NSDictionary * dic in array) {
                             QSModelItems * items = [[QSModelItems alloc] initWithDictionary:dic];
                             [weiboArray addObject:items];
                         }
                         [self.tableview.dataArray addObjectsFromArray:weiboArray];
                         [self.tableview reloadData];
                     }
              errorHandler:^(NSError *error) {}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.35 animations:^{
        baseview.left = -320;
    } completion:^(BOOL finished) {
        baseview.hidden = YES;
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    baseview.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        baseview.left = 0;
    }];
}
- (void)viewDidUnload {
    [self setTableview:nil];
    [super viewDidUnload];
}
@end
