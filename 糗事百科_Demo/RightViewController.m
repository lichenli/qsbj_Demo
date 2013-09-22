//
//  RightViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface RightViewController ()

@property (nonatomic,strong)NSMutableDictionary * dataDic;

@property (nonatomic,strong) NSArray * array ;


@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeimage) name:kNSNotificationTheme object:nil];
        
        // 1 . 数据
        _dataDic = [[NSMutableDictionary alloc] init];
        
        NSArray * array = @[
                            @"正常",
                            @"滑动",
                            @"缩放",
                            @"飘移"
                            ];
        
        [_dataDic setObject:array forKey:@"滑动方式"];
        
        [_dataDic setObject:[NSArray arrayWithObjects:@"白天", @"黑夜",nil] forKey:@"主题"];
        
    }
        // 2. 主题
        _array = [[NSArray alloc] init];

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
    // 获取主题个数
    _array = [[[ThemeManger shareinster].imageDic allKeys] copy];
    
}
#pragma mark - tableview deleget
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return  [[_dataDic objectForKey:([_dataDic allKeys][section])] count];
    if (section == 0) {
        return 4;
    }else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"leftTableview";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.textLabel.textColor = [[ThemeManger shareinster] loadfontColor:@"Content_color"];
    cell.textLabel.text = [_dataDic objectForKey:( [_dataDic allKeys][indexPath.section])][indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    
    switch (indexPath.section) {
            
        case 0:
        {
            MMDrawerAnimationType animationTypeForSection = [[MMExampleDrawerVisualStateManager sharedManager] leftDrawerAnimationType];
            if(animationTypeForSection == indexPath.row){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;}
            else {
                cell.accessoryType = UITableViewCellAccessoryNone;}
            break;
        }
            
        case 1:
        {
            // 对勾的样式
            if ([_array[indexPath.row] isEqualToString:[ThemeManger shareinster].themeName]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        
            break;
        }

        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:indexPath.row];
            [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:indexPath.row];
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 1:
        {
            // 更换主题
            [ThemeManger shareinster].themeName = [self loadarray][indexPath.row];
            // 发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationTheme object:nil];
            // 保存主题
            [[ThemeManger shareinster] saveThemeName];
            // 刷新对勾
            [self.tableview reloadData];
            
            break;
        }
            
        default:
            break;
    }
}
#pragma mark - 切换主题
-(void)changeimage
{
    UIImage * image = [[ThemeManger shareinster] loadImage:@"bg_home.jpg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
}

#pragma mark - 获取主题
-(NSArray *)loadarray
{
    _array = [[[ThemeManger shareinster].imageDic allKeys] copy];
    return _array;
}

#pragma mark -  设置 viewForHeader
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataDic allKeys][section];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTableview:nil];
    [super viewDidUnload];
}
@end
