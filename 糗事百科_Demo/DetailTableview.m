//
//  DetailTableview.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "DetailTableview.h"
#import "DetailTableViewCell.h"

@implementation DetailTableview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



#pragma mark - tableview 代理方法


#pragma mark - tableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Detailtableview";
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commentItem = self.dataArray[indexPath.row];
    
    // 页码
    cell.pageLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];

    return cell;
}

#pragma mark - 计算每一行的高度
-(CGFloat)hightForCell:(NSIndexPath *) indexPath
{
    CommentItems * items = self.dataArray[indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@",items.content];
    CGSize resultSize =[string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(295, 1000)];
    return resultSize.height;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailViewController * detailVC = [[DetailViewController alloc] init];
//    detailVC.items = self.dataArray[indexPath.row];
//    [self.viewController.navigationController pushViewController:detailVC animated:YES];
//    
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = [self hightForCell:indexPath];
    
    return  height + 40;
}

@end
