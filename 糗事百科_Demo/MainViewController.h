//
//  MainViewController.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainTableview.h"
#import "DataModels.h"
#import "BaseViewController.h"

@interface MainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet MainTableview *tableview;

@property (nonatomic, strong) NSString * URLstring;  // URL地址

@property (nonatomic, strong)NSMutableArray  * styleArr;



@end
