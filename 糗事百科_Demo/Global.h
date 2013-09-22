//
//  Global.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#ifndef _____Demo_Global_h
#define _____Demo_Global_h

#import "UIViewController+MMDrawerController.h"
#import "UIViewExt.h"
#import "MKNetworkKit.h"
#import "ThemeManger.h"
#import "ThemeButton.h"
#import "ThemeUimageView.h"
#import "UIImageView+WebCache.h"
#import "QSEngine.h"
#import "DataModels.h"


// URL
#define URLgan  @"/article/list/suggest"  //干货
#define URLnen  @"/article/list/latest"   //嫩草
#define URLnear @"/article/list/nearby"   //嫩草

#define URLday @"/article/list/day"       //天
#define URLweek @"/article/list/week"     //周
#define URLmonth @"/article/list/month"   //月


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 数据请求地址
#define kURL @"m2.qiushibaike.com"

#endif
