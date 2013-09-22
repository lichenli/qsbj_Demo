//
//  ThemeManger.m
//  My_weibo
//
//  Created by lichen on 13-8-23.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "ThemeManger.h"

@implementation ThemeManger

static ThemeManger *instance = nil;

+ (ThemeManger *)shareinster
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ThemeManger alloc] init];
    });
    return instance;
}
// 重写初始化方法   加载 theme.plist 文件
- (id)init
{
    self = [super init];
    if (self) {
        // 获取主题路径的 文件
        NSString * themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        _imageDic = [[NSDictionary dictionaryWithContentsOfFile:themePath] copy];
        
        // 初始化 主题名字 拿到主题路径
        NSString * themename = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (themename) {
            self.themeName = themename;
        }else{
            self.themeName = kDefaultThemeName;
        }
        
    }
    return self;
}
- (void)dealloc
{
    _themeName = nil;
    _imageDic = nil;
    _fontColorDic = nil;
}
// 获取路径
-(NSString *)themePath
{
    NSString * rootpath = [[NSBundle mainBundle] resourcePath];     // 获取应用程序路径
    
    NSString * themepath = [_imageDic objectForKey:_themeName];     // 拼接主题包的路径
    
    return [rootpath stringByAppendingPathComponent:themepath];     // 返回这个路径
}

// 切换主题
-(void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        _themeName = [themeName copy];
    }
    
    NSString * filePath = [[self themePath] stringByAppendingPathComponent:@"config.plist"];
    
    self.fontColorDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
}

// 保存 主题名字
-(void)saveThemeName
{
    [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// 更换  主题图片
-(UIImage *)loadImage:(NSString *)themeName
{
    if (themeName == nil) {
        return nil;
    }
    NSString * filepath =[[self themePath] stringByAppendingPathComponent:themeName];
    return [UIImage imageWithContentsOfFile:filepath];

}
// 更换  字体颜色
-(UIColor *)loadfontColor:(NSString *)themeColor
{
    if (!themeColor) {
        return nil;
    }
    
    NSDictionary * dic =  [self.fontColorDic objectForKey:themeColor];
    float  r = [[dic objectForKey:@"R" ] floatValue];
    float  g = [[dic objectForKey:@"G" ] floatValue];
    float  b = [[dic objectForKey:@"B" ] floatValue];

    return [UIColor colorWithRed:r  green:g  blue:b  alpha:1];
    
}

@end
