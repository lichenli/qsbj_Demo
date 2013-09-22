//
//  ThemeButton.m
//  My_weibo
//
//  Created by lichen on 13-8-23.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonImage) name: kNSNotificationTheme object:nil];
        
        
    }
    return self;
}
-(void) resetImage
{
    UIImage * img   =  [[ThemeManger shareinster] loadImage:self.imageName];
    UIImage * bgimg =  [[ThemeManger shareinster] loadImage:self.BGimageName];
    
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(-20, 0, 20, 0)];
    bgimg = [bgimg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 0, 2)];

    [self setImage:img forState:UIControlStateNormal];
    [self setBackgroundImage:bgimg forState:UIControlStateNormal];
}

-(void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        _imageName = imageName;
        
        [self resetImage];
    }
}
-(void)setBGimageName:(NSString *)BGimageName

{
    if (_BGimageName != BGimageName) {
        _BGimageName = BGimageName;
        
        [self resetImage];
    }
}
-(void)changeButtonImage
{
    [self resetImage];
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
