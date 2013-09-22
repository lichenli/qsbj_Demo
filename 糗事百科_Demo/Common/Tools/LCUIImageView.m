//
//  LCUIImageView.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-16.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "LCUIImageView.h"

@implementation LCUIImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initViews];
}

-(void)initViews
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.touchBlock) {
        _touchBlock();
    }
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
