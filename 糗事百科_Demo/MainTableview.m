//
//  MainTableview.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "MainTableview.h"
#import "ContentCell.h"
#import "DetailViewController.h"
#import "UIView+Additions.h"

@implementation MainTableview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - tableview 代理方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Maintableview";
    ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.items = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    detailVC.items = self.dataArray[indexPath.row];
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算Cell的高度
    QSModelItems * items = self.dataArray[indexPath.row];
    float height = [BaseView loadBaseViewHeight:items];
    
    return  height + 20;
}

@end
