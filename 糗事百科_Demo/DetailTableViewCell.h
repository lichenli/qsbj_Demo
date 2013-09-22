//
//  DetailTableViewCell.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItems.h"
#import "RTLabel.h"

@interface DetailTableViewCell : UITableViewCell

{
    UILabel  * nameLabel;     // 昵称
    UILabel  * commentLabel;  // 评论
}

@property (nonatomic, strong)CommentItems * commentItem;
@property (nonatomic, strong)UILabel      * pageLabel;

@end
