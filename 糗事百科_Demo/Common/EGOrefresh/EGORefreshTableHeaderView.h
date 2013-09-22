//
//  EGORefreshTableHeaderView.h
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EGOViewCommon.h"

@interface EGORefreshTableHeaderView : UIView {
	
	id _delegate;
	EGOPullRefreshState _state;   //设置状态  枚举类型

	UILabel *_lastUpdatedLabel;  // 最有更新
	UILabel *_statusLabel;       // 状态
	CALayer *_arrowImage;        // 图层 上拉箭头
	UIActivityIndicatorView *_activityView;  // 菊花
	

}

@property(nonatomic,assign) id <EGORefreshTableDelegate> delegate;  // 代理

- (void)setState:(EGOPullRefreshState)aState;     /// 设置下拉的状态

- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor;  // 初始化

- (void)refreshLastUpdatedDate;                                                            //记录最后一次  加载信息
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;                          // 滑动
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;                     // 停止拖拽 
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;       // 数据载入完成
 
@end
