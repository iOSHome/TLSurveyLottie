//
//  TLAnimationRefreshFooter.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/11/1.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLAnimationRefreshFooter.h"


@interface TLAnimationRefreshFooter()

@property (nonatomic,strong) LOTAnimationView *animView;

@end


@implementation TLAnimationRefreshFooter

#pragma mark - 重写方法

#pragma mark 初始化配置（添加子控件）
- (void)prepare
{
    [super prepare];
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置动画
    self.animView = [LOTAnimationView animationNamed:@"RefreshFooterAnim"];
    self.animView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.animView];
    self.animView.loopAnimation = YES;
    
}

#pragma mark - 实现父类的方法
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.animView.bounds = CGRectMake(0, 0, 200, 80);
    self.animView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateRefreshing) {
        self.animView.animationSpeed = -3.0;
        [self.animView play];
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        self.animView.animationSpeed = 1.0;
        [self.animView stop];
    }
}

#pragma mark 监听拖拽比例
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    if (self.state != MJRefreshStateIdle) return;
    
    self.animView.animationProgress = pullingPercent;
}

@end
