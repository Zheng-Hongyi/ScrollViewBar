//
//  EWScrollViewVerticalBar.m
//  TestScrollView
//
//  Created by Yi on 2019/10/24.
//  Copyright © 2019 Yi. All rights reserved.
//

#import "EWScrollViewVerticalBar.h"

static void *EWScrollViewVerticalBarContext = &EWScrollViewVerticalBarContext;
@interface EWScrollViewVerticalBar ()

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *pColor;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) kScrollViewState currentState;

@end

@implementation EWScrollViewVerticalBar

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor progressColor:(UIColor *)pColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgColor = bgColor;
        self.pColor = pColor;
        [self loadSubviews];
    }
    return self;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:EWScrollViewVerticalBarContext];
}

#pragma mark - Public

- (void)bindScrollView:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:EWScrollViewVerticalBarContext];
}

- (void)updateScrollState:(kScrollViewState)state {
    switch (state) {
        case kScrollViewState_Start:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 1.0;
            }];
            [self canPerformAction:@selector(hideSelf) withSender:nil];
        }
            break;
        case kScrollViewState_End:
        {
            [self performSelector:@selector(hideSelf) withObject:nil afterDelay:1.0];
        }
            break;
        default:
            break;
    }
}

- (void)hideSelf {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == EWScrollViewVerticalBarContext) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            [self updateProgressViewByScrollView:self.scrollView];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Private

- (void)drawCorners {
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.progressView.layer.cornerRadius = self.progressView.bounds.size.width / 2;
}

- (void)updateProgressViewByScrollView:(UIScrollView *)scrollView {
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat frameHeight = scrollView.frame.size.height;
    CGRect pFrame = self.progressView.frame;
    self.progressView.frame = CGRectMake(pFrame.origin.x, frameHeight * (scrollView.contentOffset.y / (contentHeight)), pFrame.size.width, frameHeight * (frameHeight / contentHeight));
}

- (void)loadSubviews {
    [self.layer setMasksToBounds:YES];
    self.backgroundColor = self.bgColor;
    [self addSubview:self.progressView];
    self.alpha = 0.0;
    [self drawCorners];
}

#pragma mark -

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [UIView new];
        _progressView.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
        _progressView.backgroundColor = self.pColor;
    }
    return _progressView;
}

@end
