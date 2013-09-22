//
//  SendViewController.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-21.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "BaseViewController.h"

@interface SendViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textview;

@end
