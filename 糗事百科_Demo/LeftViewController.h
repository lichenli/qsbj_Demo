//
//  LeftViewController.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
{
    UIImageView * headImageview;
    ThemeButton * systemButton;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
