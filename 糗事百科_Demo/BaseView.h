//
//  BaseView.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//  显示内容视图

#import <UIKit/UIKit.h>
#import "LCUIImageView.h"
#import "RTLabel.h"
#import "CommentView.h"
#import "DataModels.h"


@interface BaseView : UIView
{
    LCUIImageView      *  userImageView;         // 头像
    UILabel            *  nameLabel;             // 名字
    UILabel            *  contentLabel;          // 内容
    LCUIImageView      *  imageview;             // 图片
    CommentView        *  bottomView;            // 顶赞
    ThemeUimageView    * subimageview;           // 背景图片
    LCUIImageView      * fullImageView;          // 放大的图片
    
}

@property (nonatomic, strong)QSModelItems * items;

// 计算BaseView的高度
+(CGFloat)loadBaseViewHeight:(QSModelItems *)items;

@end
