//
//  TLAnimationRefreshHeader.m
//  TLSurveyLottie
//
//  Created by lichuanjun on 2017/11/1.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLAnimationRefreshHeader.h"

@interface TLAnimationRefreshHeader()

@property (nonatomic,strong) LOTAnimationView *animView;

@end

@implementation TLAnimationRefreshHeader

#pragma mark - 重写方法

#pragma mark 初始化配置（添加子控件）
- (void)prepare
{
    [super prepare];
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置控件的高度
    self.mj_h = 80;
    
    // 设置动画视图
    self.animView = [LOTAnimationView animationNamed:@"RefreshHeaderAnim"];
    self.animView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.animView];
    
    self.animView.loopAnimation = YES;
}

#pragma mark 设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.animView.bounds = CGRectMake(0, 0, 80, 80);
    self.animView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.animView stop];
            break;
        case MJRefreshStatePulling:
            [self.animView pause];
            break;
        case MJRefreshStateRefreshing:
            [self.animView play];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    if (self.state != MJRefreshStateIdle) return;
    
    self.animView.animationProgress = pullingPercent;
}

@end
