//
//  BaseViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-20.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - 显示HUD提示 在注销账号时
//-(void)showHUDwithTitle:(NSString *)title withHiddenDelay :(NSTimeInterval) delay
//{
//    MBProgressHUD * HUD = [[MBProgressHUD alloc]initWithWindow:self.shareApp.window];
//    [self.shareApp.window addSubview:HUD];
//    
//    UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
//    HUD.customView = imageview;
//    
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText = title;
//    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(delay);
//    } completionBlock:^{
//        [HUD removeFromSuperview];
//    }];
//    
//}
#pragma mark - 不添加图片
-(void)showHUD:(NSString *)title withHiddenDelay:(NSTimeInterval)delay withView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}
#pragma mark - 显示HUD提示 提示下载进度

-(void)showHUD:(NSString *)title  withView:(UIView *)view
{
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = title;
    
    //设置模式为进度框形的
    hud.mode = MBProgressHUDModeDeterminate;
    [hud showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            hud.progress = progress;
            usleep(50000);
        }
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}
#pragma mark - 返回
-(void)pushback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
