//
//  LCTableview.h
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

typedef void (^PullDownBlock)(UITableView * tableview);
typedef void (^PullUpBlock)(UITableView * tableview);


@interface LCTableview : UITableView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;               // 下拉刷新
    EGORefreshTableFooterView *_refreshFooterView;               // 上拉刷新
    BOOL _reloading;                                             // 添加状态
    UIButton * _moreButton;                                      // 点击加载更多
}

@property (nonatomic, strong) NSMutableArray * dataArray;        // 数据源
@property (nonatomic, strong)PullDownBlock  pullDownBlock;       // 下拉刷新
@property (nonatomic, strong)PullUpBlock    pullUpBlock;         // 上拉刷新
@property (nonatomic, assign)BOOL         isMore;                // 没有更多数据
@end