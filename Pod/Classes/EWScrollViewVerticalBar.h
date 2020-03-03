//
//  EWScrollViewVerticalBar.h
//  TestScrollView
//
//  Created by Yi on 2019/10/24.
//  Copyright © 2019 Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, kScrollViewState) {
    kScrollViewState_None,
    kScrollViewState_Start, // 开始拖拽
    kScrollViewState_End    // 拖拽结束并停止滚动
};

@interface EWScrollViewVerticalBar : UIView

- (instancetype)initWithFrame:(CGRect)frame
              backgroundColor:(UIColor *)bgColor // 整体的背景色
                progressColor:(UIColor *)pColor; // 进度指示器的背景色


// 绑定的ScrollView，即要跟踪那个scrollView的拖拽
- (void)bindScrollView:(UIScrollView *)scrollView;

- (void)updateScrollState:(kScrollViewState)state;

@end

NS_ASSUME_NONNULL_END
