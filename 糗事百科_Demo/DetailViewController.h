//
//  DetailViewController.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//  详情界面

#import <UIKit/UIKit.h>
#import "QSModelItems.h"
#import "DetailTableview.h"
#import "BaseViewController.h"

@interface DetailViewController : BaseViewController

@property (nonatomic, strong)QSModelItems  * items;

@property (weak, nonatomic) IBOutlet DetailTableview *tableview;

@end
