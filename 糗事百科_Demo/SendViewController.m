//
//  SendViewController.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-21.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "SendViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CMActionSheet.h"

@interface SendViewController ()
{
    ThemeUimageView * baseview;
    ThemeUimageView * titleview;    //titleview
}

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textview becomeFirstResponder];
    
    [self initviews];
}

#pragma mark - 设置navigtionBar的样式
-(void)initviews
{
    // 设置电池条的样式
    UIApplication *myApp = [UIApplication sharedApplication];
    [myApp setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    // 添加主题navigationBar
    baseview = [[ThemeUimageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 44)];
    baseview.userInteractionEnabled = YES;
    baseview.imageName = @"head_background.png";
    [self.navigationController.view addSubview:baseview];
    
    // 添加button
    ThemeButton * leftbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    [leftbutton addTarget:self action:@selector(pushback) forControlEvents:UIControlEventTouchUpInside];
    leftbutton.frame = CGRectMake(8, 5, 0, 0);
    leftbutton.imageName = @"icon_back_enable@2x.png";
    [leftbutton sizeToFit];
    [baseview addSubview:leftbutton];
    
    // 发送button
    ThemeButton * rightbutton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(280, 5, 0, 0);
    [rightbutton addTarget:self action:@selector(sendqiushi) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.imageName = @"icon_send@2x.png";
    [rightbutton sizeToFit];
    [baseview addSubview:rightbutton];
    
    // 添加阴影效果
    baseview.layer.shadowColor = [UIColor blackColor].CGColor;
    baseview.layer.shadowOpacity = 0.6;
    baseview.layer.shadowOffset = CGSizeMake(0, 1);
    baseview.layer.shadowPath = [UIBezierPath bezierPathWithRect:baseview.bounds].CGPath;
    
    // 相机
    ThemeButton * imageButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(280, 160, 24, 24);
    [imageButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    imageButton.imageName = @"icon_upload@2x.png";
    [imageButton sizeToFit];
    [self.textview addSubview:imageButton];
}
#pragma mark 发送糗事
-(void)sendqiushi
{
    QSEngine * engine = [[QSEngine shareEngine] initWithHostName:kURL customHeaderFields:nil];
    
    
    [engine requestWithURL:@"/article/create"
                    params:nil
                httpMethod:@"POST"
                     blcok:^(MKNetworkOperation * result) {
                         
                         [self showHUD:@"发送成功" withHiddenDelay:2 withView:self.view.window];
                     }
              errorHandler:^(NSError *error) {}];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 选取相片
-(void)selectImage
{
    __weak SendViewController * this = self;
    // 提示框
    CMActionSheet * actionSheet = [[CMActionSheet alloc] init];
    [actionSheet addButtonWithTitle:@"相 册" type:CMActionSheetButtonTypeBlue block:^{
        
        UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
        imgPickerCtrl.delegate = this;
        imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //相册
        [this presentViewController:imgPickerCtrl animated:YES completion:^{
        }];
        
    }];
    [actionSheet addSeparator];
    [actionSheet addButtonWithTitle:@"照相机" type:CMActionSheetButtonTypeBlue block:^{
        
        //1.判断设备是否有前置摄像头. UIImagePickerControllerCameraDeviceRear 后置摄像头,还有一个是front是前置摄像头
        BOOL result = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (result) {
            
            UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
            imgPickerCtrl.delegate = this;
            
            //源类型, 相机
            imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置为前置摄像头
            imgPickerCtrl.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            imgPickerCtrl.showsCameraControls = YES;
            
            [this presentViewController:imgPickerCtrl animated:YES completion:^{
                
            }];
            
        }else
        {
            [self showHUD:@"请检查您的设备摄像头" withHiddenDelay:2 withView:_textview];
        }
        
    }];
    [actionSheet addSeparator];
    [actionSheet addButtonWithTitle:@"取 消" type:CMActionSheetButtonTypeRed block:^{}];


    [actionSheet present];
    
}

#pragma mark - 取消滑动
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];      // 手势操作区域
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];      // 手势操作区域
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];      // 手势操作区域
    
    [UIView animateWithDuration:0.35 animations:^{
        baseview.left = 320;
    } completion:^(BOOL finished) {
        [baseview removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextview:nil];
    [super viewDidUnload];
}
@end
