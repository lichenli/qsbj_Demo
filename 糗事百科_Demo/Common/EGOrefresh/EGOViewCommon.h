//
//  EGOViewCommon.h
//  TableViewRefresh
//
//  Created by  Abby Lin on 12-5-2.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef TableViewRefresh_EGOViewCommon_h
#define TableViewRefresh_EGOViewCommon_h

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

#define  REFRESH_REGION_HEIGHT 65.0f

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
} EGOPullRefreshState;

typedef enum{
	EGORefreshHeader = 0,
	EGORefreshFooter	
} EGORefreshPos;


// 定义代理方法
@protocol EGORefreshTableDelegate
// 下拉的时候调用此方法
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos;
// 判断刷新状态情况，正在刷新或者是没刷新
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view;
@optional
// 返回刷新时间，回调方法
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view;
@end

#endif
