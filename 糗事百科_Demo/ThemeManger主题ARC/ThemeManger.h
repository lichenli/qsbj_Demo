//
//  ThemeManger.h
//  My_weibo
//
//  Created by lichen on 13-8-23.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultThemeName @"白天"

#define kThemeName @"themeName"

#define kNSNotificationTheme @"NSNotificationTheme"

@interface ThemeManger : NSObject

@property (nonatomic, copy)NSString * themeName;           // 主题名字

@property (nonatomic, strong)NSDictionary * imageDic;      // 主题图片

@property (nonatomic, strong)NSDictionary * fontColorDic;  // 主题颜色


+ (ThemeManger *)shareinster;

// 更换  主题  颜色
-(UIImage *)loadImage:(NSString *)themeName;
-(UIColor *)loadfontColor:(NSString *)themeColor;

// 保存 主题名字
-(void)saveThemeName;

@end
