//
//  LCTableview.m
//  糗事百科_Demo
//
//  Created by lichen on 13-9-19.
//  Copyright (c) 2013年 Lichen. All rights reserved.
//


#import "LCTableview.h"
#import "ContentCell.h"
#import "DetailViewController.h"
#import "UIView+Additions.h"

@implementation LCTableview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 初始化一个下拉刷新
        [self createHeaderView];
    }
    return self;
}
-(void)awakeFromNib
{
    // 1. 初始化一个下拉刷新
    [self createHeaderView];
}

-(void)createHeaderView
{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.bounds.size.height,
                                     self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
	[self addSubview:_refreshHeaderView];
    // 更新最后加载日期
    [_refreshHeaderView refreshLastUpdatedDate];
    
    self.delegate = self;
    self.dataSource = self;
    
#pragma -mark 点击加载更多
    //加载更多
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor = [UIColor clearColor];
    _moreButton.frame = CGRectMake(0, 0, kScreenWidth, 40);
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_moreButton setTitle:@"点击加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(getNextPageView) forControlEvents:UIControlEventTouchUpInside];
    
    // 菊花
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(100, 10, 20, 20);
    activityView.tag = 2000;
    [activityView stopAnimating];
    [_moreButton addSubview:activityView];
    
    self.tableFooterView = _moreButton;
}
// 下载数据完成
-(void)testFinishedLoadData
{
    // 下载完成
    [self finishReloadingData];
}
- (void)finishReloadingData
{
	
    // 没有在下载
	_reloading = NO;
    
    // 如果下拉存在
	if (_refreshHeaderView) {
        
        // 数据载入完成
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        [self setFooterView];
    }
    // 点击加载按钮
    [self stopLoadMore];
}
#pragma mark - 初始化 上拉刷新
-(void)setFooterView
{
    
    CGFloat height = MAX(self.contentSize.height, self.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.frame.size.width,
                                              self.bounds.size.height);
    }else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.frame.size.width, self.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        // 最后一次更新
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

// 移除下拉
-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}


#pragma mark - 开始下载 数据

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:0.1];
        
    }else if(aRefreshPos == EGORefreshFooter)
	{
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
}

//刷新调用的方法   下拉
-(void)refreshView
{
    //刷新数据
    if (_pullDownBlock) {
        _pullDownBlock(self);
    }
    
    [self testFinishedLoadData];   //刷新完成
    
}
//加载调用的方法   上拉
-(void)getNextPageView
{
    if(_pullUpBlock){
        [self startLoadMore];
        _pullUpBlock(self);
    }
    
    [self testFinishedLoadData];   //刷新完成
    
}
-(void)startLoadMore
{
    [_moreButton setTitle:@"正在加载.." forState:UIControlStateNormal];
    _moreButton.enabled = NO;                                //不可以使用
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2000];
    [activityView startAnimating];
}
-(void)stopLoadMore
{
    [_moreButton setTitle:@"点击加载更多.." forState:UIControlStateNormal];
    _moreButton.enabled = YES;                                //不可以使用
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2000];
    [activityView stopAnimating];
}



#pragma mark - 滑动的代理
// 正在滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

//停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark - 下拉刷新 的代理

// 下拉时候调用这个方法
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	// 开始加载数据
	[self beginToReloadData:aRefreshPos];
	
}

// 判断是否是在刷新
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
    return  _reloading;
}

// 返回刷新时间，回调方法
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
    return [NSDate date];
}


#pragma mark - tableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Basetableview";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - 重写reloadData 方法
-(void)reloadData
{
    [super reloadData];
    
    if (!_isMore) {
        // 添加下拉刷新
        [self setFooterView];
    }else{
        [_refreshFooterView removeFromSuperview];
    }
    
}

@end
