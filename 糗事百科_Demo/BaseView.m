//
//  BaseView.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "BaseView.h"
#import "UIView+Additions.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 换字体颜色的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(labelColor) name:kNSNotificationTheme object:nil];
        // 添加视图
        [self initViews];
    
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:kNSNotificationTheme];
}

-(void)initViews
{
    // 1. 背景图片
    subimageview = [[ThemeUimageView alloc] initWithFrame:CGRectZero];
    subimageview.imageName = @"block_background@2x.png";
    subimageview.frame =CGRectMake(-2, -4, 310, 0);
    subimageview.userInteractionEnabled = YES;
    [self addSubview:subimageview];
    
    // 2. userImageView
    userImageView = [[LCUIImageView alloc] initWithFrame:CGRectZero];
    userImageView.userInteractionEnabled = YES;
    [self addSubview:userImageView];
    
    // 3. namelabel
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [[ThemeManger shareinster]loadfontColor:@"Name_color"];
    [self addSubview:nameLabel];
    
    // 4. 添加内容
    contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = [[ThemeManger shareinster] loadfontColor:@"Content_color"];
    [self addSubview:contentLabel];
    
    // 5. 添加图片
    imageview = [[LCUIImageView alloc] initWithFrame:CGRectZero];
    imageview.backgroundColor = [UIColor blackColor];
    imageview.userInteractionEnabled = YES;
    [self addSubview:imageview];
    
    // 6. 顶赞视图
    bottomView = [[CommentView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor clearColor];
    bottomView.userInteractionEnabled = YES;
    [self addSubview:bottomView];
    
}
#pragma mark - set方法
-(void)setItems:(QSModelItems *)items
{
    if (_items != items) {
        _items = items;
    }
    // 1. 内容
    contentLabel.text = items.content;
    
    // 2. 用户名
    if (_items.users && _items.users != NULL) {
        
        // 头像
        NSString * str = [NSString stringWithFormat:@"http://pic.moumentei.com/system/avtnew/%@/%@/thumb/%@",[_items.users.userIdentifier substringToIndex:4],_items.users.userIdentifier,_items.users.icon];
        UIImage * image = [[ThemeManger shareinster] loadImage:@"thumb_avatar.png"];
        userImageView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        NSURL * url = [NSURL URLWithString:str];
        [userImageView setImageWithURL:url];
        
        // 昵称
        nameLabel.text = _items.users.login;
    }
    
    // 3. 图片
    if (_items.image && _items.image != NULL) {
        NSString * string = [self Regular:_items.image];
        NSString * str = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/small/%@",[string substringToIndex:4], string, _items.image];
        [imageview setImageWithURL:[NSURL URLWithString:str]];
        
        
    // 4. 图片放大
        //转换坐标，将当前视图的坐标转换成显示在window上的坐标
        CGRect frame = [imageview convertRect:imageview.bounds toView:self.window];
        fullImageView = [[LCUIImageView alloc] initWithFrame:frame];
            // 大图URL
        NSString * bigimageStr = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/medium/%@",[string substringToIndex:4], string, _items.image];
        
        __weak LCUIImageView  * full = fullImageView;
        __weak BaseView       * this = self;
        
        imageview.touchBlock = ^{
            

            // 图片放大
            full.contentMode = UIViewContentModeScaleAspectFit;
            full.backgroundColor = [UIColor blackColor];
            full.userInteractionEnabled = YES;
            [full setImageWithURL:[NSURL URLWithString:bigimageStr]];
            [this.window addSubview:full];
            
            // 添加保存按钮
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"icon_save@2x"] forState:UIControlStateNormal];
            [button addTarget:this action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(kScreenWidth - 70, kScreenHeight - 40, 49, 36);
            [this.window addSubview:button];
            
            // 返回时候的block
            full.touchBlock = ^{
        
                [UIView animateWithDuration:0.6 animations:^{
                    full.frame = frame;
                } completion:^(BOOL finished) {
                    [full removeFromSuperview];
                }];
                [[UIApplication sharedApplication] setStatusBarHidden:NO];
                // 移除保存按钮
                [button removeFromSuperview];
            };
            
            // 隐藏电池条
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            [UIView animateWithDuration:0.6 animations:^{
                full.frame = [UIScreen mainScreen].bounds;
            } completion:NULL];
        };
            
        }

#pragma mark - 视图views的Frame
    //  2. 头像昵称
    if (_items.users && _items.users.icon!= NULL) {
        userImageView.frame = CGRectMake(10, 10, 32, 32);
        nameLabel.frame = CGRectMake(userImageView.right +5, 15, 200, 20);
    }else
    {
        userImageView.frame = CGRectZero;
        nameLabel.frame = CGRectZero;
    }
    
    //  3. 内容
    float height = [self hightForCommentLabel];
    contentLabel.frame = CGRectMake(10, userImageView.bottom + 5, 290, height);
    
    //  4. 图片
    if (_items.image && _items.image != NULL) {
        imageview.frame = CGRectMake(10, contentLabel.bottom + 5, 100, 100);
    }else
    {
        imageview.frame = CGRectMake(10, contentLabel.bottom , 0, 0);
    }
    
    // 5. 顶赞
    bottomView.frame = CGRectMake(10, imageview.bottom , 280, 40);
    
    //  1. 背景
    float baseheight = [BaseView loadBaseViewHeight:_items];
    self.frame = CGRectMake(10, 5, 300, baseheight);
    
    subimageview.height = baseheight + 10;
}

#pragma mark - 图片地址
-(NSString *)Regular:(NSString * )string
{
    NSString *regStr = @"\\d+";   // 正则表达式的语法
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regStr options:NSRegularExpressionCaseInsensitive error:NULL];
    NSArray *array = [reg matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *result in array) {
        NSString * st = [string substringWithRange:result.range];
        return st;
    }
}

#pragma mark - 计算Label的高度
-(CGFloat)hightForCommentLabel
{
    NSString * string = [NSString stringWithFormat:@"%@",_items.content];
    CGSize resultSize =[string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000)];
    return resultSize.height;
}

#pragma mark - 计算baseview的高度
+(CGFloat)loadBaseViewHeight:(QSModelItems *)items
{
    
    float height = 0;
    
    // 1. 计算头像高度
    if (items.users && items.users.icon != NULL) {
        height = 10 + 32 + 5;
    }else{
        height += 10;
    }
    
    // 2. 计算内容高度
    RTLabel * label = [[RTLabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:15];
    label.width = 290.0;
    label.text = items.content;
    height += label.optimumSize.height;
    
    // 3. 计算图片高度
    if (items.image && items.image != NULL) {
        height += (100 + 10);
    }
    // 4. 计算顶赞
    height += 45;
    
    return height;
}

#pragma mark - 保存图片
-(void)saveImage:(UIButton *)button
{
    [button setBackgroundImage:[UIImage imageNamed:@"icon_save_active@2x.png"] forState:UIControlStateNormal];
    UIImage * image = fullImageView.image;
    if (image != nil) {
        // HUD
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)(hud));
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    MBProgressHUD * hud = (__bridge MBProgressHUD *)(contextInfo);
    
    UIImageView * imageviews = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    hud.customView = imageviews;
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    [hud hide:YES afterDelay:1.0];
    
}

#pragma mark - 换字体颜色的通知
-(void)labelColor
{
    nameLabel.textColor = [[ThemeManger shareinster]loadfontColor:@"Name_color"];
    contentLabel.textColor = [[ThemeManger shareinster] loadfontColor:@"Content_color"];
    // 刷新tableview
    MainViewController * mainVC = (MainViewController *)self.viewController;
    [mainVC.tableview reloadData];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
