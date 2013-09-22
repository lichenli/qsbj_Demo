//
//  LCAppDelegate.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "LCAppDelegate.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "BaseNavigationController.h"

@implementation LCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
// 1. 初始化 main left right
    MainViewController             * mainVC = [[MainViewController alloc] init];
    LeftViewController             * leftVC = [[LeftViewController alloc] init];
    RightViewController          * ringhtVC = [[RightViewController alloc] init];
    BaseNavigationController * navigationVC = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    
// 2. 初始化MMDraw
    _mmdrawerControl = [[MMDrawerController alloc] initWithCenterViewController:navigationVC leftDrawerViewController:leftVC rightDrawerViewController:ringhtVC];
    
    [_mmdrawerControl setMaximumLeftDrawerWidth:270.0];                              // 打开宽度
    [_mmdrawerControl setMaximumRightDrawerWidth:100.0];
    [_mmdrawerControl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];      // 手势操作区域
    [_mmdrawerControl setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
// 3. 添加动画效果
    [_mmdrawerControl
     setDrawerVisualStateBlock:^(MMDrawerController *DrawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(DrawerController, drawerSide, percentVisible);
         }
     }];
    
    self.window.rootViewController = _mmdrawerControl;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
