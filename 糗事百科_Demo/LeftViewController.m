//
//  LeftViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "LeftViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MainViewController.h"
#import "EliteViewController.h"
#import "BaseNavigationController.h"


@interface LeftViewController ()

@property (nonatomic,strong)NSMutableDictionary * dataDic;
@property (nonatomic,strong)NSMutableArray      * dataArray;

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeimage) name:kNSNotificationTheme object:nil];
        
        // 1 . 数据
        _dataDic = [[NSMutableDictionary alloc] init];

        
        [_dataDic setObject:@"随便逛逛" forKey:@"随便逛逛"];
        [_dataDic setObject:@"随便逛逛" forKey:@"精华"];
        [_dataDic setObject:@"随便逛逛" forKey:@"有图有真相"];
        [_dataDic setObject:@"随便逛逛" forKey:@"穿越"];
        
        [_dataDic setObject:@"随便逛逛" forKey:@"我收藏的"];
        [_dataDic setObject:@"随便逛逛" forKey:@"我参与的"];
        [_dataDic setObject:@"随便逛逛" forKey:@"我发表的"];
        
        [_dataDic setObject:@"随便逛逛" forKey:@"审核新糗事"];
        
        // 2. 数据
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"随便逛逛",@"精华",@"有图有真相",@"穿越",@"",@"我收藏的",@"我参与的",@"我发表的",@"",@"审核新糗事",nil];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:kNSNotificationTheme];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeimage];
    
    // 1.头像view
    headImageview = [[UIImageView alloc]initWithFrame:CGRectMake(-50, 0, 370, 44)];
    UIImage * image = [[ThemeManger shareinster] loadImage:@"side_button_background@2x.png"];
    headImageview.image = image;
    headImageview.userInteractionEnabled = YES;
    [self.view addSubview:headImageview];
    
    // 2.systemBUtton
    systemButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    systemButton.BGimageName = @"side_setting_icon_active@2x.png";
    systemButton.frame = CGRectMake(270, 0, 44, 44);
    [headImageview addSubview:systemButton];
    
}

#pragma mark - 切换主题
-(void)changeimage
{
    // 背景
    UIImage * image = [[ThemeManger shareinster] loadImage:@"side_menu_textural@2x.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    // navigtation
    headImageview.image = [[ThemeManger shareinster] loadImage:@"side_button_background@2x.png"];

    // 设置tableview的分割线
    UIImage * lineimage = [[ThemeManger shareinster] loadImage:@"side_menu_background@2x.png"];
    self.tableview.separatorColor =[UIColor colorWithPatternImage:lineimage];
    
    // Tableview Fream
    self.tableview.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight - 44);
}


#pragma mark - tableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"leftVC";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * string = _dataArray[indexPath.row];
    if ([string isEqualToString:@""]) {
        return 10;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            MainViewController * main = [[MainViewController alloc] init];

            BaseNavigationController * bas = [[BaseNavigationController alloc]initWithRootViewController:main];
            [self.mm_drawerController setCenterViewController:bas withCloseAnimation:YES completion:^(BOOL finished) {
            }];
            
            break;
        }
        case 1:
        {

            EliteViewController * eliteVC = [[EliteViewController alloc]init];
            BaseNavigationController * bas2 = [[BaseNavigationController alloc]initWithRootViewController:eliteVC];
            [self.mm_drawerController setCenterViewController:bas2 withCloseAnimation:YES completion:^(BOOL finished) {
                
            }];

            
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        case 5:
        {
            
            NSLog(@"%d",indexPath.row);

            break;
        }
        case 6:
        {
            break;
        }
        case 7:
        {
            break;
        }
        case 9:
        {
            
            NSLog(@"%d",indexPath.row);

            break;
        }
            
        default:
            break;
    }
    
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
