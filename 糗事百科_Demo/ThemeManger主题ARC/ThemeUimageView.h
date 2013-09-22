//
//  ThemeUimageView.h
//  My_weibo
//
//  Created by lichen on 13-8-23.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeUimageView : UIImageView

@property (nonatomic, strong) NSString * imageName;

//解决拉伸的bug
@property(nonatomic, assign)int topCapHeight;
@property(nonatomic, assign)int leftCapHeight;

@end
