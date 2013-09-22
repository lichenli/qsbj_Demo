//
//  BaseViewController.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-20.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


// HUD提示框
-(void)showHUD:(NSString *)title withHiddenDelay:(NSTimeInterval)delay withView:(UIView *)view;
-(void)showHUD:(NSString *)title  withView:(UIView *)view;

@end
