//
//  ContentCell.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 初始化 视图
        [self initviews];

    }
    return self;
}

-(void)initviews
{
    baseview = [[BaseView alloc] initWithFrame:CGRectZero];
    [self addSubview:baseview];    
}


#pragma mark - set方法
-(void)setItems:(QSModelItems *)items
{
    if (_items != items) {
        _items = items;
    }
    
    // 给baseview赋值
    baseview.items = _items;
}


-(void)layoutSubviews
{
    baseview.frame = CGRectMake(5, 5, 310, [BaseView loadBaseViewHeight:_items]+ 5);
    baseview.userInteractionEnabled = YES;
    
    // IOS5 需要 setNeedsLayout
    [baseview setNeedsLayout];
    
    // 重新刷新一遍  draw  重新画一次
    [self setNeedsDisplay];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}


@end
