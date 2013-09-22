//
//  ContentCell.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//  tablevieCell

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ContentCell : UITableViewCell
{
    BaseView * baseview ;       // 视图
}

@property (nonatomic, strong)QSModelItems * items; //内容

@end
