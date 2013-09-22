//
//  CommentView.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//  评论赞View

#import "CommentView.h"

@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    // 1. 顶
    dingButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    dingButton.frame = CGRectMake(0, 0, 60, 35);
    dingButton.BGimageName = @"button_vote_enable@2x.png";
    [self addSubview:dingButton];
    
    
    // 2. 踩
    caiButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    caiButton.frame = CGRectMake(dingButton.right + 10, 0, 60, 35);
    caiButton.BGimageName = @"button_vote_enable@2x.png";
    [self addSubview:caiButton];
    
    // 3. 评论
    commentButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(caiButton.right + 60, 0, 40, 35);
    commentButton.imageName = @"button_comment_enable@2x.png";
    [self addSubview:commentButton];
    
    // 4. 收藏
    voteButton = [ThemeButton buttonWithType:UIButtonTypeCustom];
    voteButton.frame = CGRectMake(commentButton.right + 10, 0, 40, 35);
    voteButton.imageName = @"button_vote_enable@2x.png";
    [self addSubview:voteButton];
    
    
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
