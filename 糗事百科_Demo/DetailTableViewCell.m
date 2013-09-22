//
//  DetailTableViewCell.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import "DetailTableViewCell.h"


@implementation DetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initviews];
    }
    return self;
}

#pragma mark - 初始化评论
-(void)initviews
{
    // 1. 昵称
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 280, 20)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.backgroundColor = [UIColor clearColor];    
    nameLabel.textColor = [[ThemeManger shareinster]loadfontColor:@"Name_color"];
    [self.contentView addSubview:nameLabel];
    
    // 2. 添加内容
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, nameLabel.bottom + 5, 295, 5)];
    commentLabel.font = [UIFont systemFontOfSize:13];
    commentLabel.numberOfLines = 0;
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.textColor = [[ThemeManger shareinster] loadfontColor:@"Content_color"];
    [self.contentView addSubview:commentLabel];
    
    // 3. 页码
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 7, 20, 20)];
    _pageLabel.backgroundColor = [UIColor clearColor];
    _pageLabel.textColor = [UIColor brownColor];
    _pageLabel.font = [UIFont systemFontOfSize:14];
    _pageLabel.textColor = [[ThemeManger shareinster]loadfontColor:@"Name_color"];
    [self.contentView addSubview:_pageLabel];

}

#pragma mark - set方法
-(void)setCommentItem:(CommentItems *)commentItem
{
    if (_commentItem != commentItem) {
        _commentItem = commentItem;
    }
    // 1. 昵称
    nameLabel.text =_commentItem.user.login;

    // 2. 评论
    commentLabel.text = _commentItem.content;
    float hight = [self hightForCommentLabel];
    commentLabel.height = hight;

}

#pragma mark - 计算Label的高度
-(CGFloat)hightForCommentLabel
{
    NSString * string = [NSString stringWithFormat:@"%@",_commentItem.content];
    CGSize resultSize =[string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(295, 1000)];
    return resultSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
