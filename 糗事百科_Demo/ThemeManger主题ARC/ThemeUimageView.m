//
//  ThemeUimageView.m
//  My_weibo
//
//  Created by lichen on 13-8-23.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "ThemeUimageView.h"

@implementation ThemeUimageView
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImageName) name:kNSNotificationTheme object:nil];
    }
    return self;
}
-(void)resetImage
{
    UIImage * image = [[ThemeManger shareinster] loadImage:_imageName];
    self.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 10, 1)];

}

-(void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        _imageName = imageName;
        
        [self resetImage];
    }
}
-(void)changeImageName
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
